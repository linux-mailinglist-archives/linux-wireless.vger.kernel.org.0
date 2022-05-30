Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535AD53798F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiE3LGs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiE3LGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 07:06:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A88D117
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 04:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F268EB80B8F
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 11:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FC6C385B8;
        Mon, 30 May 2022 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653908800;
        bh=PIMknSel6vdlDHo8m2N5toFmbS7GgtpqhCzipArqsW4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WAegGU6IHUB+Xy4hG5kW4uz9/rDV8Qi1DFRiw5/Rqx0d/0GPtbEeb+/0jD//cvrHd
         kxP8+yokCf9MNIOkRynQ6IlnlNoP8+vHjKir4accQdKbxc3CRaNZCH+G+sLZ2N+kaH
         2Uppoj4RoTxtUNECqT1aMbN0FN0FHRVyq38HZMMstvtPErSqM8CGX0ZHAEeuxMPMrC
         MaaGlRmCtVriBMX8AnWPOGXTCoOcKGes9V99+VsOgMT1woEbQd/+sUYDmVvpuUIlhS
         /5gb99gLk9urDAd5fg/OHAvSLexk9O2c+2QFRV7HEH2+N9duSYJlESBD2wIqaMpJi2
         ixH/vcO4lW7Sw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3,1/4] wifi: rtw88: Fix sparse warning for rtw8822b_hw_spec
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220524153621.19027-2-Larry.Finger@lwfinger.net>
References: <20220524153621.19027-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390879742.29197.9087460498259219353.kvalo@kernel.org>
Date:   Mon, 30 May 2022 11:06:39 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Sparse lists the following for rtw88:
> 
>   CHECK   drivers/net/wireless/realtek/rtw88/rtw8822b.c
> drivers/net/wireless/realtek/rtw88/rtw8822b.c:2500:22: warning: symbol 'rtw8822b_hw_spec' was not declared. Should it be static?
> 
> The warning arises because the external declaration for rtw8822b_hw_spec
> occurs in rtw8822be.h, which is not included in rtw8822b.h. That line is
> moved, and the now empty file rtw8822be.h is deleted.
> 
> Symbol 'rtw8822b_hw_spec' can be made constant.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

f429298d68fb wifi: rtw88: Fix sparse warning for rtw8822b_hw_spec
f86fc57f8ae3 wifi: rtw88: Fix Sparse warning for rtw8822c_hw_spec
e36db29cfdff wifi: rtw88: Fix Sparse warning for rtw8723d_hw_spec
89d8f53ff6e7 wifi: rtw88: Fix Sparse warning for rtw8821c_hw_spec

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220524153621.19027-2-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

