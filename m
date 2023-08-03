Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724F76E433
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjHCJUP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjHCJT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 05:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96463594
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 02:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB6D61D03
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 09:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3338C433C8;
        Thu,  3 Aug 2023 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691054367;
        bh=BBs5xDVfPy4kBjsyiU8qNidPHEPfQ9H3VspFwt1rOwU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LeDu4EEf7QWGBLBKVnIPQRxmIRezvKQOCpHvmRKaNiTW/VOOKhu7MB9ke1nLBfyZ5
         Bz4/EBK8cmDIpc8FPqbdteBtiKjKqj5kgh+UnDsuM5uIjSKCBS7hE54cXEG1BYK1gO
         PFlVI6IQPnIWTjD/Sp9S0JYm6FZ8ZQy0xwDVf3qFvjkazRsjWd/wVhcmiANc1vvqTc
         0Q8EsQGJAG7IFtOTjqChq2JMUFVJNpGFnW3/K6eKkRQQ/Bhpmyo/AcqIeoSf1JRwnu
         4UvyZNWPlfOlcCEMmR/AnckhGYwYW558+3ksvzaPTuP/1MZEHc9GNBT8suSNH/kxLo
         5PS8T6UlYI7Hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add handler for scan event
 WMI_SCAN_EVENT_DEQUEUED
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230717034457.22162-1-quic_wgong@quicinc.com>
References: <20230717034457.22162-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169105436499.894438.10408926666024994853.kvalo@kernel.org>
Date:   Thu,  3 Aug 2023 09:19:26 +0000 (UTC)
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

> When wlan interface is up, and 11d scan is sent to the firmware, then
> firmware needs to spend couple of seconds to complete the 11d scan. If
> normal scan from user space arrives to ath12k at this moment, then the
> normal scan request is also sent to the firmware, but the scan started
> event will be reported to ath12k until the 11d scan complete. When timed
> out for the scan started in ath12k, ath12k stops the normal scan and the
> firmware reports WMI_SCAN_EVENT_DEQUEUED to ath12k for the normal scan.
> ath12k has no handler for the event and then timed out for the scan
> completed in ath12k_scan_stop(), and ath12k prints the following error
> message.
> 
> [ 1491.604750] ath12k_pci 0000:02:00.0: failed to receive scan abort comple: timed out
> [ 1491.604756] ath12k_pci 0000:02:00.0: failed to stop scan: -110
> [ 1491.604758] ath12k_pci 0000:02:00.0: failed to start hw scan: -110
> 
> Add a handler for WMI_SCAN_EVENT_DEQUEUED and then complete the scan to
> get rid of the above error message.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9632ea57be65 wifi: ath12k: add handler for scan event WMI_SCAN_EVENT_DEQUEUED

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230717034457.22162-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

