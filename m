Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BAC7B6C82
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbjJCO4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbjJCO41 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 10:56:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3FB173F
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 07:56:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691DCC433C7;
        Tue,  3 Oct 2023 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696344973;
        bh=p0AgQWyC7sV+5Z0KZ2RWo84QUqVPvvrxy7P5WybgfBA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JteOu6smdI73xmfL2Gj/5UxP+Jfrh/iElevnZvhn2tThq0DhhZqMiBSpcPjz0gmu1
         e2je7eOU/WH7Qr+h92BTDaavu6fzHKwlYWaRbURygw27uTdX6CrJKt5xFtsWO6Q4fz
         Y8/PpPWt96bGpqDOiVR9hbT4eDMrggw6ADT6NbI37OnNqJvn4Gw67DLQP+tgiMWYJz
         vd92qWv5n7iU5z3CjNR2pNIvsynPcdAUPZA0st2MZCfnLyzI21kvKBbOz5ISTV3mB6
         qeX0TMZRFRkx+KZ+00P+/h22UH6s2vjdRpmLaC/kP2se8wzk3Lakd50OPWnbuu0cuH
         SsEYRovi07AEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Encoding regdb.bin in board-2.bin
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230131123422.24985-1-quic_karm@quicinc.com>
References: <20230131123422.24985-1-quic_karm@quicinc.com>
To:     Karthik M <quic_karm@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthik M <quic_karm@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169634497029.182212.8117239239886289035.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 14:56:12 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthik M <quic_karm@quicinc.com> wrote:

> Currently regulatory database information are in regdb.bin outside
> the board-2.bin.
> 
> In this implementation, Add support to encode the secured regdb.bin
> in board-2.bin along with the bdf files.
> 
> New api(ath12k_core_fetch_regdb) fetches the board specific regdb
> from board-2.bin. If it fails, it downloads the default regdb.
> 
> Firmware receives the binary over QMI and verifies the signing.
> If it is authentic, the binary will be used.
> 
> Renumbered the enum ATH12K_BD_IE_BOARD_EXT to '2' since it is
> not used in the code. ATH12K_BD_IE_REGDB enum will take the value '1'
> as per the ath11k upstream design.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthik M <quic_karm@quicinc.com>

It's a long time since I tested this and this doesn't apply anymore so I
cannot give you any detailed report. But IIRC I noticed in my test that
having just board.bin didn't work anymore. Please double check that, rebase and
submit v2.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230131123422.24985-1-quic_karm@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

