Return-Path: <linux-wireless+bounces-417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE545804D46
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 10:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A231C20A35
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA23D997;
	Tue,  5 Dec 2023 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJL0n1ad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD28BF1
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 09:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8417C433C7;
	Tue,  5 Dec 2023 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701767480;
	bh=QMDREhFQs+Cx0qGLE9136SPqX1lANODyvOE4w3ZTV8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kJL0n1adXyd+4aJbqeG0PPvNud7n72mRjjBl6faIYVwurj4dd0xsn4RrZmY9vCOAn
	 un8OgChvpwhvciYmoDaIHSyFcAuTJ/EjMNmTt3hJHnXDaG2A7oAoDXNAMu92IK+KB1
	 dcCXpCB+OFMdstC4JazUdfUjnlQRusUSvmC3kSdtOeHWr8MpKnRGCvfxkyhJDlLBLH
	 94VbMyYan9zgCJkfu/HkEYxami6G+J8BwngjzXkuFx8Cx69b35EZIZohYV6X50+Jqt
	 HUL1VpcuqyA4dPfnTmHKjWTg16r8uDVLUjfQVz4y2sveyhk7zVyvEFqFVgW9bLey5d
	 R9TNtyleHYJ9g==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 7D9965F7FF;
	Tue,  5 Dec 2023 17:11:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20231119182401.7630-1-jiaxun.yang@flygoat.com>
References: <20231119182401.7630-1-jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for China (CN)
Message-Id: <170176747748.1180638.6206522543570761190.b4-ty@kernel.org>
Date: Tue, 05 Dec 2023 17:11:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Sun, 19 Nov 2023 18:24:01 +0000, Jiaxun Yang wrote:
> China had updated regulations on 5150 MHz to 5350 MHz by
> "中华人民共和国工业和信息化部令（第54号）", which released
> an update to "中华人民共和国无线电频率划分规定".
> 
> The new regulation effectives from 1 July 2023.
> 
> In updated regulation, footnote "CHN44" had restricted 5150 MHz to
> 5350 MHz as in door only for Broadband Wireless Access systems.
> 
> [...]

Applied, thanks!

[1/1] wireless-regdb: Update regulatory rules for China (CN)
      commit: 8c784a10448e36dc387fe02ae6bf69f4ae0208d2

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


