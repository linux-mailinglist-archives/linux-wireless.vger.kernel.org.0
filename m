Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F727123DE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbjEZJkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242782AbjEZJjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 05:39:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788CE4E
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 02:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1CB564E8D
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 09:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB4DC4339C;
        Fri, 26 May 2023 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685093941;
        bh=1jvDYFDddIWiMkiwRme9di50H0U0k1tYRF66A/E0T+I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r5m9jmtI9Zkkmvbd+aQ9MJlZOEoXSn7NdimYdX7dU4n7nSbFPJJDOwT1u3pgWUtcB
         +VXFnJy8DAzBFIGNv6hd7LrdvlzbsnsCwEq6+vpGIadP3KD2PweUlJAqumh0Q+bRuG
         34l3mTTiwv/+PuqtlAasgJVLetRX9DbVVI6cMqlSHN7iQbqJMkb4JgXVAHWzPW+uQo
         RRqLZfXIBiagk28tgOQl5woSVKT60UTUvow5B/pJGFB9OWUE/cC8UrAGCVYVBkam62
         NGLoJa3M0CVbZrUx1KaZyP4slooQ1067t69vtw/nfW0jwUIkwhljIKw+q4nnXGyn5D
         Vsf1lBa7Dar8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Add support to parse new WMI event for 6
 GHz
 regulatory
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230502142018.20301-1-quic_rgnanase@quicinc.com>
References: <20230502142018.20301-1-quic_rgnanase@quicinc.com>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <quic_ppranees@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168509393704.23037.3611388693586746214.kvalo@kernel.org>
Date:   Fri, 26 May 2023 09:38:59 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> In order to support different power levels of 6 GHz AP and client, new WMI
> event for regulatory (WMI_REG_CHAN_LIST_CC_EXT_EVENTID) has been added in
> firmware to provide new parameters required for 6 GHz regulatory rules.
> 
> Firmware advertises its capability of handling new event in WMI service ready
> event. Based on that, host needs to set host_service_flags in WMI init command
> to indicate that host supports processing of this WMI event. Based on
> advertised host capability, firmware sends event WMI_REG_CHAN_LIST_CC_EXT_EVENTID.
> This new event contains 2G/5G/6G reg rules with additional power value fields
> for 6GHz and regd is built accordingly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

342527f35338 wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230502142018.20301-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

