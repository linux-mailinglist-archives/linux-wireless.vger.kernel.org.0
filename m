Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37776B643
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjHANwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 09:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHANwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 09:52:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C8ED
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 06:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC105615AF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 13:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F6C433C7;
        Tue,  1 Aug 2023 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690897960;
        bh=GtyRiFHthsDjtKkiPp/i8BU3l3WVaTFcYHgdGtnnWJg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BElcm7HGDPmhq3g+fa/Lz8p4qtc1eSd18g7VJJZB+v0Swv83UFY1O3wLsD/wXY9E/
         kAgk/cL0xT+eSswB7xru01PwcXBYb0Uk7TWd92B8PFgxTxS8IPWv+2U5tVtLCwUwlI
         pif0jnoSIJSnan49WSToXy7REI7ueF8bpRE9O2CiioLzLFEJYPBz8e0CiLrhZxfSOm
         7jDI5oMzqZlUt514Qi4g5LxzSOsyLulApU4Vhd1NNolyUbd1HbetkWjcMDUd9ukJVS
         8M1yPcagu+ZDhSTT+05XPBVPMTERHwGP7vcg3mAWJUinvIalX0vo2TZwWVOajfWvfv
         loNNLtfl53eGg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath12k: Fix a NULL pointer dereference in
 ath12k_mac_op_hw_scan()
References: <20230726092625.3350-1-quic_wgong@quicinc.com>
Date:   Tue, 01 Aug 2023 16:52:37 +0300
In-Reply-To: <20230726092625.3350-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 26 Jul 2023 05:26:25 -0400")
Message-ID: <87fs52yimy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> In ath12k_mac_op_hw_scan(), the return value of kzalloc() is directly
> used in memcpy(), which may lead to a NULL pointer dereference on
> failure of kzalloc().
>
> Fix this bug by adding a check of arg.extraie.ptr.

"wifi:" missing from subject.

> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

This on one line.

I can fix both of these in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
