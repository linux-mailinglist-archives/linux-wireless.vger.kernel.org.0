Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1446DB11
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhLHScZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhLHScV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:32:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F7FC0617A1
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 10:28:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BDE0B820CD
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7C1C341CA;
        Wed,  8 Dec 2021 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988127;
        bh=0N7Fo1yhsEqdjPm+zAn94TkbiCbPYeuDri4xCvnKsNU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tCZ1/4CTplu53TfWkDWJYMpCyxwLhOPQmzXplOe/Ox4IvSX74/WnMOhR6vi/aq+Wn
         IyZ0TGAa85hhXZI/wlK2R1EjfuE0ZvKTa2o2YsEinvC75sQrgH1Dke2XaTjGuk40sJ
         +Nz0bxtv2m/N2I2P1nCxDanfhFxeIqCd9HY09HEQ0eUFpNhiGInwsJs85+q0cRpDXO
         1E37zlUoU2wu/s8bpsYDbQJ3XN6/j/dQoXPVWsyqLdcQci4lGCudE8v4ITfJnBKOoh
         H1x9WjtdcpyrVvKD4F3RHVE2kqovMLQp6F2oKcZjS+IAkFyr+GSJJBnULUarcuk5eM
         K5iY2n53wakMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: refine tx_pwr_tbl debugfs to show channel and
 bandwidth
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211129020626.6384-1-pkshih@realtek.com>
References: <20211129020626.6384-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898812412.25635.99647604635311304.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:28:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Show channel and bandwidth in debugfs tx_pwr_tbl to make it easier
> to understand which tx power table is shown currently, and to reduce
> additional checks through other ways.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

157289376e29 rtw88: refine tx_pwr_tbl debugfs to show channel and bandwidth

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211129020626.6384-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

