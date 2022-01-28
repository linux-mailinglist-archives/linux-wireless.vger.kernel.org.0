Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F294D49FB03
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiA1Npq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:45:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32854 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242423AbiA1Npo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:45:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 818DEB824F5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5D4C340E0;
        Fri, 28 Jan 2022 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643377541;
        bh=NjUDQHcjwK8tiNfbwas8lP+FG2pv6UYPQhclQj/xg8k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U1MRGDNuTmFojua+kl5Aex8Qp42imoq3ArREE3DrOngcd2rW/94ZisIy2f57zRL/D
         +Z4q22pvx1RCZWNLEoIqRMZtRHzTdoPrmXddPxkkWMpDWFbqr3/Va7DZctnJkiRMuW
         qPcHXH5Ao3wFWYth+dMSc/6ho0Bce8EXrvdAK6DRO3szRjhBQPwdBsxYq4z+CbM/7G
         GctXYnJFV5MU37iHfBs2/SEdyF7nCeA3TvifF/sv69a2urPoUv2imnHU15KVxa2Xj+
         TbXJXAASiqe0NppQx/ZrZO9sAoFrNhVfgdJyxKABPDCjjeooNhnEypd98j24fqzddA
         ZsX3psE8UHWWA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Cheng Wang <quic_chengwan@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add register read debugfs interface for WCN6855
References: <20220125063731.3049556-1-quic_chengwan@quicinc.com>
Date:   Fri, 28 Jan 2022 15:45:38 +0200
In-Reply-To: <20220125063731.3049556-1-quic_chengwan@quicinc.com> (Cheng
        Wang's message of "Tue, 25 Jan 2022 14:37:31 +0800")
Message-ID: <878rv0ezy5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cheng Wang <quic_chengwan@quicinc.com> writes:

> Add debugfs interface reg_addr/reg_value and use these two interfaces
> to read register value.
> For example, execute the following commands to read WCN6855 HW register of
> =E2=80=9Cmemtype=3D0xa offset=3D0x3a00d0=E2=80=9D:
>
> $ echo 0xa 0x3a00d0>reg_addr
> $ cat reg_value
> 0x10200000
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICO=
NZ_LITE-1
>
> Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>

This had new warnings, fixed in the pending branch:

drivers/net/wireless/ath/ath11k/debugfs.c:1207: line length of 96 exceeds 9=
0 columns
drivers/net/wireless/ath/ath11k/debugfs.c:1253: line length of 94 exceeds 9=
0 columns
drivers/net/wireless/ath/ath11k/debugfs.c:1318: line length of 91 exceeds 9=
0 columns
drivers/net/wireless/ath/ath11k/qmi.c:1673: line length of 94 exceeds 90 co=
lumns

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
