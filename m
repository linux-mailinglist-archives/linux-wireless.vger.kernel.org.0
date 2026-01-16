Return-Path: <linux-wireless+bounces-30909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A62ED32140
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 14:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAF7A3005F1F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93640230BD9;
	Fri, 16 Jan 2026 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qYVzz9bG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A63227BA4;
	Fri, 16 Jan 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571299; cv=none; b=sF1/xdeI0J/M5w4MauBOds1/lB0ZQdtEIyVAOGJ/00kPmD0JEdgs7igBgdF29YTQQZZo5BLkyrMZxlLvHrIhkN8G9KWq9JDC7RJDSc/WRhuh8U43HZdfVHOOQOjIicKNbLWujk/5DwLVTgCbxOjjfwSD5kWkDRIHA6s1o3d7aME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571299; c=relaxed/simple;
	bh=x1KqGJREAE7Xc+fRDnaIP1NDO+QIyioIcN5HqDVbpAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOkLlGSn49dCq4ZMfKV6sy8iLc41UmRKwmXNfpsSJKltCWJergILpPuSxQozB7WveD6KgEw9w1Tf8wyL+XC8+Kjc4vut3KsYenq8aIve8rLygy4dB25Zd74LnBY0fw25+kySxiT+CQqCgqxCwc50m2C/E6U0fCQf19JHQ8BKCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qYVzz9bG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x1KqGJREAE7Xc+fRDnaIP1NDO+QIyioIcN5HqDVbpAs=;
	t=1768571298; x=1769780898; b=qYVzz9bGnWphin4d72gGTLWDD+2AjxalNhNT/VoUfJVSkcK
	Y5+Jc46FvjjsbN/gqaHtD61JCVYvN8taryEu6wrBO+EB3ckSiHhYcIFQWe30Y0fAvr3JxhIOjWcEJ
	lVm7PnK4c4T0PT8lhJVTnm7hBepIAhb0GYt3VEfSygEJ5ZfRzUzw+ZVTBUSBt1tXAkH1ndIOnv/Zw
	sCsNFLUSbfKMZTRtk7JOFf0n7W6OKdo0B+QndNboCmtYnYBzlnMbIRFvQVfh9rq6tKqqaXgGiRJbS
	UBHCrD1ywols3s0ringH2iZ4haFTagEYcieG2LvTfZ0Ztevg92DKs8V+YuKJg3sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vgkBT-0000000DShG-1Ygw;
	Fri, 16 Jan 2026 14:48:15 +0100
Message-ID: <a061b95ea32ce1e82b76333e648cd6bc82fa7b04.camel@sipsolutions.net>
Subject: Re: wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Zong-Zhe Yang
	 <kevin_yang@realtek.com>, Zilin Guan <zilin@seu.edu.cn>, Ping-Ke Shih
	 <pkshih@realtek.com>, linux-wireless@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>
Date: Fri, 16 Jan 2026 14:48:14 +0100
In-Reply-To: <0ad16f51-8caf-469b-882d-4928560c0b64@web.de> (sfid-20260116_133831_166237_4C53803E)
References: <20260116074836.1199951-1-zilin@seu.edu.cn>
	 <1d32418f-c315-4ce4-9b4c-6781bda72cfe@web.de>
	 <acc90353107248b98215847e56bb374b@realtek.com>
	 <0ad16f51-8caf-469b-882d-4928560c0b64@web.de>
	 (sfid-20260116_133831_166237_4C53803E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

For the record, everyone, please just ignore Markus. I've told him
numerous times to just leave us alone.

johannes

