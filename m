Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4566DCFE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjAQL5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbjAQL5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 06:57:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DC2200E
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 03:57:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA953B81187
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 11:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD341C433F0;
        Tue, 17 Jan 2023 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673956644;
        bh=A342a7RFzg4iD3R93Fd5dxm412ejRXcLsmBRWPhFJ70=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sQXUa+/mrdDCejmva0FEcoXqB3/uVGIW+O0VQENR6TFySI2KxFnDL/MrhAy1+TIl1
         C/EJbkImkBo5QKj5CImRZEtYZeGjP0Ipw05MYg/J5HZmrhI9b5EgeLX6wgmqxqKIKV
         /U7/MuSLmJEvfow0bcWO4qmqOCL6Pt9FbHhDuUYtoLfWQqsZAYStrSOhp/vILyDo+d
         7mlTe9eELwmtmOrPpxrN9wl90JPoJ4IONXigHeusxKF9ElKp5mt35l/y7nroH6MUtF
         ox0jeKrxUvQ1h+aFhqoBJeW5sJLrBNBALtb6oN+YUr0WL7QP9onfAOL4M8SDdv9hVT
         b8SbgBplTJL+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: add channel 177 into 5 GHz channel list
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221220101912.30816-1-quic_wgong@quicinc.com>
References: <20221220101912.30816-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167395664181.22891.8452249494456590360.kvalo@kernel.org>
Date:   Tue, 17 Jan 2023 11:57:23 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Add support for the 5 GHz channel 177 with center frequency 5885 MHz and
> operating class 125 per IEEE Std 802.11ax-2021, Table E-4.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e5e94d10c856 wifi: ath11k: add channel 177 into 5 GHz channel list

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221220101912.30816-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

