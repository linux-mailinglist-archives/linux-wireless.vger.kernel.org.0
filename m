Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C876E444
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjHCJYK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 05:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCJYJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 05:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD4212D
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 02:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E59BB61CEF
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 09:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952DC433C7;
        Thu,  3 Aug 2023 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691054645;
        bh=RWA4535ZuKGIVttpsyu29l+cYWXZI3ZPl5R1XmuKXF0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=P090hTeYE0R8lVbBQF3YBJilUXqZWAS1SnNTBHf0tHjONr0ia51gbKKo8HnOei1ry
         SZM56VprOPBZgEEsVbyOY9wRZhS6fyD0iri9w8tCn9UxLFjlKmFfC3oxtk66Y3zOcQ
         fxiG0/An0/15vO1hkFwhn7/rxii42sQNuBnkZPnmN7SF9pq1FjKneYJ1o2HxtgdhqW
         sstROC0XYB5OPwos5qi3kWeIR+f9YTY5paKdzdVw8XWwSLtdDtXaQHHUdg8lKdSlgo
         Sl04mti3/pj9/ncO9h7KPBq0B2cIQWcF1zzK0NUiNrWLuIpuHK5A9ye/W9hM93bYl5
         8yKmCa25UdsJQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: ath12k: configure RDDM size to MHI for
 device
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230721055305.20420-2-quic_wgong@quicinc.com>
References: <20230721055305.20420-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169105464227.894438.15435946207134709277.kvalo@kernel.org>
Date:   Thu,  3 Aug 2023 09:24:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> RDDM is RAM DUMP DEBUG module, it is used to debug issues when firmware
> encounters an error.
> 
> The rddm_size is needed by firmware while MHI enter RDDM state. Add it
> to support device recovery when ath12k receive MHI_CB_EE_RDDM message.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I'm not sure what "support device recovery" means exactly. How does this patch
change functionality from user's point of view?

No need to resend because of this, I can add that to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230721055305.20420-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

