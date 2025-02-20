Return-Path: <linux-wireless+bounces-19183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89146A3D3CF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC87018906ED
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F861EB9ED;
	Thu, 20 Feb 2025 08:56:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58F1B3927
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041775; cv=none; b=WZNO0a9p/ACPZXpHSXzrVSzR923euMVaZdC98gyJLsDmhfeOUmbogu3cuaL3wiRkAYdfpO8PdcwVLCgeAI05dS0090wCfP73SqhQZgwzqb7dsOjB8wCNoYW5DpWzm3vF9ZJFaiRgqt/EDKUyxCnsPTIrxeRlgnfNZ/wBrmaHmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041775; c=relaxed/simple;
	bh=trqklhrlX1A2M0la0TqHhVt7pGH1c0jdEp9eGSs8ND0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi0qjQAVObIeF85g1s6S81KUFbm5W235YC+jXGEdffmvITNdQSskSVduZH615BJVVag5iRyoWoatjxBKeibiCycg/O1015awbrtwS4X1yFfy3saSpe3HmGIcMkfMEIr1idtQ/bUojqBjUHqh3xqpXyNJninjU5izH4PuLgrkULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=wens.tw; arc=none smtp.client-ip=140.112.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wens.tw
Received: by wens.tw (Postfix, from userid 1000)
	id 8154A5FB8F; Thu, 20 Feb 2025 16:50:00 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: Re: [PATCH v4 1/3] wireless-regdb: allow NO-INDOOR flag in db.txt
Date: Thu, 20 Feb 2025 16:49:55 +0800
Message-Id: <174004130216.1744486.17335599893056910422.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220003103.4484-1-pkshih@gmail.com>
References: <20250220003103.4484-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 08:31:01 +0800, Ping-Ke Shih wrote:
> For certain regulations, frequency range is outdoor only, which flag should
> be NO-INDOOR, but db2fw.py doesn't allow this flag.
> 
> As suggestion, only fill NO-INDOOR flag in db.txt, but ignore this rule
> in parsing to binary.
> 
> 
> [...]

Sorry, I had to immediately do a force push as I mistakenly squashed in
database binary changes into one of the commits.

Here are the new commit hashes:

[1/3] wireless-regdb: allow NO-INDOOR flag in db.txt
      https://git.kernel.org/wens/wireless-regdb/c/3dd7ceb8aa75
[2/3] wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and 5Ghz for 2021
      https://git.kernel.org/wens/wireless-regdb/c/4d754a1d5a3e
[3/3] wireless-regdb: Update frequency range with NO-INDOOR for Oman (OM)
      https://git.kernel.org/wens/wireless-regdb/c/8c8308a154df

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

