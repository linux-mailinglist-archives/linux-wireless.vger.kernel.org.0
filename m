Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9B508D74
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380705AbiDTQiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380692AbiDTQh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 12:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02140A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 09:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8304261A0D
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 16:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE845C385A4;
        Wed, 20 Apr 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472510;
        bh=9ejcmMDe5SdSPg8+S6T6l9v/lhyBsRC+v5fAmICWhf4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G0esuMOiYcfLJhQ/UB7sCdfiBh/6Ap5hQ7GQs+Sa7Ndwab7+NMhzkUJbkzD8qA4dQ
         Ei7n45c8TeCu7DRwhkC+GV4m2QDmScPeAHGgB5izYpK7vz3LsHUIEkq0W/8P/1TqGQ
         kOwB4zon3v9gJEr48RYlDA3a/k8MBoPEg6mf96ucWjgXY5ux20d88+odxoT8m9Wwqx
         Mbi5a0tU/T9Aw7HXkCBhYTUSDDFFf8wD17N5JWSWLP4CcvickD9JhswCWx7MCuRZ7m
         9FBrNfNZQVUw89rv3nwfh2KUOAgK6RuRWRIPFzNWmg09THzSNEcfyQ138N3G2vEQMG
         URbLo5IqwpstQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] ath11k: add support for extended wmi service bit
References: <20220401120948.1312956-1-quic_bqiang@quicinc.com>
        <20220401120948.1312956-2-quic_bqiang@quicinc.com>
        <4f421eab-1ace-51c6-e677-42b32b6afc56@quicinc.com>
Date:   Wed, 20 Apr 2022 19:35:06 +0300
In-Reply-To: <4f421eab-1ace-51c6-e677-42b32b6afc56@quicinc.com> (Jeff
        Johnson's message of "Fri, 1 Apr 2022 11:07:51 -0700")
Message-ID: <87h76nogqt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/1/2022 5:09 AM, Baochen Qiang wrote:
>> From: Wen Gong <quic_wgong@quicinc.com>
>>
>> Currently the wmi service bis is report from firmware, it is divided
>
> "bis" is a typo?
> Also use of "Currently" here is confusing since it seems you are
> changing that behavior. But the firmware reporting isn't changing,
> only the host processing is changing.
>
> So perhaps:
> When the WMI service bits are reported from firmware they are divided
> into multiple segments, with 128 bits in each segment.
>
>> to 128 bits for each segment. The first segment is processed by
>> ath11k_wmi_service_bitmap_copy(), the second segment is processed by
>> ath11k_service_available_event() with WMI_TAG_SERVICE_AVAILABLE_EVENT,
>> When the service bit exceed 256 bits, then firmware report it by tag
>> WMI_TAG_ARRAY_UINT32 in WMI_SERVICE_AVAILABLE_EVENTID.
>>
>> ath11k does not process the third segment, this is to extend the wmi
>
> Here is where you can use "currently". And this is also a good place
> to say why the change is needed since that is also missing from the
> commit text. So consider:
> Currently ath11k does not process the third segment. Upcoming features
> need to know if firmware support is available for the features, so add
> processing of the third segment.
>
> Also IMO the implementation details below do not need to be in the
> commit text.
>
> I suspect Kalle can just apply these comments to his pending branch.

Did that now, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=d98a4c9bd0b32824ad9ee2d24ecabb345edfaafe

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
