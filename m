Return-Path: <linux-wireless+bounces-416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C3804D36
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 10:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E4D1C20B27
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79A3D96D;
	Tue,  5 Dec 2023 09:06:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 01:06:55 PST
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77914D3
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 01:06:55 -0800 (PST)
Received: by wens.tw (Postfix, from userid 1000)
	id DE5A75FCE8; Tue,  5 Dec 2023 16:59:23 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] wireless-regdb: Makefile: Reproducible signatures
Date: Tue,  5 Dec 2023 16:59:13 +0800
Message-Id: <170176669164.1176895.2576180821287643746.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116221828.301564-1-briannorris@chromium.org>
References: <20231116221828.301564-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 16 Nov 2023 14:18:16 -0800, Brian Norris wrote:
> Per openssl-mime(1):
> 
>        -noattr
> 	   Normally when a message is signed a set of attributes are
> 	   included which include the signing time and supported
> 	   symmetric algorithms. With this option they are not included.
> 
> [...]

Applied, thanks!

[1/1] wireless-regdb: Makefile: Reproducible signatures
      commit: 9e0aee64cd2347b45d6d29a65105c2926c0b8dbc

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

