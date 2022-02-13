Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B04B3DFB
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Feb 2022 23:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiBMWZ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Feb 2022 17:25:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBMWZ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Feb 2022 17:25:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BED5468C
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 14:25:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB3CFB80BED
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 22:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473CEC004E1;
        Sun, 13 Feb 2022 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644791117;
        bh=6TiCAtkOA30O6+IrGW5hZ1QCXVrdhWmQ6yyS+woEdo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLQvjlMicWaEMpplc6gU/WgrnRBbUybf9A2IG3yGnLWe6fMrlXmSX0MGTooK7Puu3
         th0spt/ZFWzIjtB/J/1Uxtae/joslMZ+pUKhhcW7csyyIWcpR7idrXL9rxMYQYavnG
         /Zjmy1nGQzg2hzbLqO5OhlA1HfxjYjIcTq/sqFg4L+BukuPsDDjWq5tW2e2gSVT3gM
         K2NZ04MKkT30PABQCIoVlolanm2Tm7yL3zf1Bg8Kamtd5N2F/+JhZ3RWGielMciDFp
         BFb/N0mPK/aNqgpWkwHIbgbCDBffP4qJE0l9luWMJUOLg7JdoLFDJNcYPPSAaEt7YS
         2VG+lLFr/L61g==
Date:   Sun, 13 Feb 2022 16:25:16 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for China (CN)
Message-ID: <YgmFTLBiMD+cEjvX@ubuntu-x1>
References: <ae43589a-6ca4-4856-8f7f-b631ce44993b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae43589a-6ca4-4856-8f7f-b631ce44993b@www.fastmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Feb 12, 2022 at 04:29:50PM +0000, Jiaxun Yang wrote:
> China had updated regulations on ISM frequencies by
> "工信部无〔2021〕129号".
> 
> The new regulation effectives from Jan 1 2022.
> 
> Update regdb accroading to it's attachment "2400MHz、5100MHz
> 和 5800MHz 频段无线电发射设备射频技术要求".
> 
> Announcement: https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4ae71252eab42928daf0ea620976e4e.html
> Attachment: https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
> 
> Those documents are only available in Chinese.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Reduce 3dBm for 5150-5350 MHz due to TPC restriction
> ---

Applied, thanks!
