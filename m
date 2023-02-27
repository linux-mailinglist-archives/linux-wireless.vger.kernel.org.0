Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6606A41AA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 13:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjB0M0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 07:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0M03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 07:26:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA421CF59
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 04:26:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED32C60D54
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E76C433D2;
        Mon, 27 Feb 2023 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677500787;
        bh=NWYcefWMGiJtQtWkVlsBbS8T38GxvFGeYVBhy11A6jo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kT/hGlUWVeyDb80mqmh97ccuUY8AuVsE6F166ITxuM8f6j6GZONG9Z9nO6OKgaaOD
         VF+pNlq7dqYKomIgImhp7vXMgle403G86W21uj07JlsFBLTyMVnsFbPtnXq4FqDN3G
         eI+VDYh1gG3FT+H8ko2N/EnPTqZ0hBm2e53XBxlToGOQ+b9K2/rDQ7RxZDHEWFszQ5
         cjvnvTxgE7NW1sistxT+c7aM/Wlwqfs7SGnLNsX8Xp4XyDDezNHgXeeqATjteECg7U
         an9EjfeYbqiRDb5ef/Xa2uKep3ncdb3t64NeK5+0X2Mc+Wz3BnBvueFWYEc5Q8LJTB
         UfN1WNxqGJr6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: ath11k: modify accessor macros to match
 index
 size
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1666128501-12364-2-git-send-email-quic_msinada@quicinc.com>
References: <1666128501-12364-2-git-send-email-quic_msinada@quicinc.com>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167750078195.17465.18276986078298720145.kvalo@kernel.org>
Date:   Mon, 27 Feb 2023 12:26:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <quic_msinada@quicinc.com> wrote:

> HE PHY is only 11 bytes, therefore it should be using byte indexes
> instead of dword. Change corresponding macros to reflect this.
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

a96f10422e74 wifi: ath11k: modify accessor macros to match index size
38dfe775d0ab wifi: ath11k: push MU-MIMO params from hostapd to hardware
8077c1bbbc28 wifi: ath11k: move HE MCS mapper to a separate function
ebf82988f844 wifi: ath11k: generate rx and tx mcs maps for supported HE mcs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1666128501-12364-2-git-send-email-quic_msinada@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

