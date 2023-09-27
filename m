Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127657AF9F1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 07:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjI0FTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 01:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjI0FTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 01:19:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7255FD4
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 22:10:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEFAC433C8;
        Wed, 27 Sep 2023 05:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695791401;
        bh=3pSV5XDCtO13XD805MCW3In/6s76oMfmdYsUpvAdOyM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AK2QOuvcVVw+pxKtJ84KNEyQO4DNRx4GB5YCYP06T8SLD2mf6jjJ4IQfeaMMb/J5f
         X6vUeOiVGJoajSD1nVB6aO6APV9I5yQlWclpG3CyEmYPMQVIklnBExfb/EEnnjCVoY
         ppCPTfkZn2q3ChU4DJJBACwNqLM4JWQQte7zKpCJxV0CItSS7fV9+zAk4ynrgPLBtI
         muiRGpMOd3isP2+Tnw+22Mo/FXyhH7w3Po+qTer4lUPr5G5ZN5WEPZ5hDSBI9hIKfu
         AOK7/1Zp6iaADKdoLNhq/OrhpGu3t5Xcjlsyu00DVN4T7zBCaBIa/puN1kyOttAQYn
         6Nm70KrZvwI7Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath11k: mac: fix struct
 ieee80211_sband_iftype_data handling
References: <20230926163350.2641064-1-kvalo@kernel.org>
        <70a75205-8f27-4e73-9d32-d92b6f7bec68@quicinc.com>
Date:   Wed, 27 Sep 2023 08:12:04 +0300
In-Reply-To: <70a75205-8f27-4e73-9d32-d92b6f7bec68@quicinc.com> (Jeff
        Johnson's message of "Tue, 26 Sep 2023 13:55:16 -0700")
Message-ID: <874jjgjj2z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 9/26/2023 9:33 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> Commit e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer
>> with
>> sparse") added sparse checks for struct ieee80211_sband_iftype_data handling
>> which immediately found an issue in ath11k:
>> drivers/net/wireless/ath/ath11k/mac.c:7952:22: warning: incorrect
>> type in argument 1 (different address spaces)
>> drivers/net/wireless/ath/ath11k/mac.c:7952:22:    expected struct ieee80211_sta_he_cap const *he_cap
>> drivers/net/wireless/ath/ath11k/mac.c:7952:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *
>> The problem here is that we are accessing sband->iftype_data
>> directly even
>> though we should use for_each_sband_iftype_data() or similar. Fortunately
>> there's ieee80211_get_he_iftype_cap_vif() which is just we need here so use it
>
> nit: just *what* we need

I'll add that, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
