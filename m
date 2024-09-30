Return-Path: <linux-wireless+bounces-13311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA4A989BC4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB9B1C21608
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305D15FD13;
	Mon, 30 Sep 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfpoUuqW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5915F3F9
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682255; cv=none; b=HkiwrIu07T+pQiGc1d1XdwqWuN+w99kM/Cp8XhTWPTC0Txld9VHg1g6mxdA3kWe/kSuLhWCz5tJLFt0kC22jiPZBJO6mMgLRBoNPdFoHxRdeZm5I4kM/yK8mrl+3TZVOFgNXAyIGMUByI519hxZegDjgxcALFCw9oxfNMCE3Mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682255; c=relaxed/simple;
	bh=xxf1l2hHGhTyY+vHC4GmV3hYmZKbKsC5HjLSzoG8TE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AVFyu3c1HwuWnnXMLS3OaQ8f/M+TEQNxqIHbFYB3vjfP9jyISrtkMrVs7w8I1SGSsSCzFFRwDEYH+vmR6gokshpWwfDMcUFcO4Iw8bK92VhcmBHsvBIWFzmuEnEQWSPxMeR/mT45dmSUFTE9Uf1J70V6cSrt3h2U94lPRCyW2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfpoUuqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC8C4CECE;
	Mon, 30 Sep 2024 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727682254;
	bh=xxf1l2hHGhTyY+vHC4GmV3hYmZKbKsC5HjLSzoG8TE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qfpoUuqWWsM0Tm3s1YH6kYDULeb62XLFZALZVrk44whcEL83IPNcWGzx1iyA+1bmF
	 2VDuy0BIzOTOa6Brz0f7rKkAXEGwgKO2/iDKh4VsQI0aVmNXiiOte2x2YmlYPxJsWW
	 iWwBLheYqMnu0zmjwPvQeYCfr7SBlVAOfLew7h2wxm/ac0qBekEysgMCMKpXNk+Zxq
	 wIVAe1NluDaivmTg9FoOZqTBouxJfgPOxZVt5dJKp4rk36WgYyNI0No74fkKre8LEj
	 Ucz0RbOHZQ022WfwZK0W78ZCakKbAqMQ4jGmGUCr4/5ujZrwXsF9L89Ox02lkD0TYe
	 jQrniyKLMcvsw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 0C9205FC24;
	Mon, 30 Sep 2024 15:44:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240911054848.22003-1-pkshih@gmail.com>
References: <20240911054848.22003-1-pkshih@gmail.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_wireless-regdb=3A_Correct_regulatory?=
 =?utf-8?q?_rules_of_6GHz_frequency_for_T=C3=BCrkiye_=28TR=29?=
Message-Id: <172768225104.2546520.12278685247351915767.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 15:44:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Wed, 11 Sep 2024 13:48:48 +0800, Ping-Ke Shih wrote:
> As 7b of Table 3 on [1], frequency range is 5945-6425 MHz.
> 
> [1] https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf
> 
> 

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Correct regulatory rules of 6GHz frequency for Türkiye (TR)
      https://git.kernel.org/wens/wireless-regdb/c/8e3d27cc7d6f

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


