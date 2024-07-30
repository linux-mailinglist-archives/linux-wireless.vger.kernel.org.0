Return-Path: <linux-wireless+bounces-10683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC0941134
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68701F23D04
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2EE19580A;
	Tue, 30 Jul 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ugf7IYCj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA81166316;
	Tue, 30 Jul 2024 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340381; cv=none; b=G2NQ53NDX4dt8ggdcaffQ/AOwD9Q7QpOLpf5S7SDvr6HpbAVO8N/KB14Loxg1TsYcuoQXwmvVDXD1Pcz6sGOssPR9U3/Fk4er0SZWgziZtF1AaVsJ6wlYfHzGeYxNXtCVmL11tWuRZrJWZZpoQNWjdIT2dtzxJvUvAKqhdT9j78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340381; c=relaxed/simple;
	bh=3U2t4PjSm3nGE8tUHltVJ/FufrtRhfcNuKwP2zsJLvE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hmdCz+rOJcujNqNUJ3zSdO2fqvH7fSCR2rx81FsS2jHt3S6Ydrlyd7ozoP0TgLKF2MwAgq1GHX7DNnvHh0c4nr5aZ9fZpfx0qhwucqAsz3eVt29y7kEN1WEzuuuR7ovDXz2L98AHYGYz+zmh9Bv5TuFXGLNrrMbQu7FYZrad92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ugf7IYCj; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722340374; bh=rfuhs/Z+9bw5iQ2Bo/tcqR1/U5bKvoVkGTLb5omlojc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ugf7IYCjSzDJh/zWUzxMmY5bqU1VFwUqNyY7c6MmXLQUindOXi3E8lzqMY6q2epqC
	 gK73xVYHQNfriLyvFuKJ9Fya2+JP5Zvv+SUZUCAoQIlFerBTV27pdwfmGokxjYV1LO
	 OncFn+YpgGEYd+HNkgIPZdvcg0rzxiATJdhBe6uY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id BB1A7E97; Tue, 30 Jul 2024 19:46:49 +0800
X-QQ-mid: xmsmtpt1722340009t3xxspdre
Message-ID: <tencent_48A8AECCEEC30C8EE7C8C6F692C2064D4906@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25ttYYXMSLL7LDhJwHo7h14cxc7k5mpeuZwgYP8Mgv1XHhcsz0T9b
	 7TwKBMYlbE/WcyWEdhBLspwEWyduLVLQ9sL1c7Y8ktRrqr9ckpBOBZ9YhP/ctFYI9iVT0nI6s/uq
	 0GE6DMKC+DECxAxzO4G3bp02TFcLFaeHQ5Qw9mmheAZyWH42X4gtztPQjPuu6JlP3OZ3WKqh37mn
	 tN7gey74LGv+D+j7bnCI1DREyy+zsJPLoBXCVT9sCdJd2CIVjHIYFfcSG2ea7XrHZlCgGUYEJkPK
	 Rta2CchhEQqgrBYl0htASiWroGERVje13kIS4xdhNCsNt7+QmmR23+p1pxacHQs+fosNYAkQuEvu
	 8Zi37Euz6c+fADGzWMyBYHBF9ffeCr+UGJKkTrIxgq3nRfX11W5yZMnPxs/sWJK9ZrLS/dEk8MxB
	 RWjjtrrucIwa1Q0MtSZImZnePJElsJdKQZe2wyiqfgVQ/MQvrAy+cUm7da+w1s94bbE6Z2ncpCsb
	 4Y2CLfvG2leTzmbmYmW5Db9M6XZsX6002O16yjNZhVcCt4jvQ20vazRqerVo8KhEl4rD/JMBDkFX
	 zogRkkzWGy4C1HVh0m/OrYTLwXyL0Vr1XMxW3/4dvFJsDJ3v394dvGQeAfoukTe8LK69bRuKZS3W
	 UL/GCnFEF5X3skDiUO5HSu3jOHsmviKsp6boWxddLNbIjBg850ay1xlHWSosusVTKFiMRMtV0yu9
	 vpVmhKQLP/2r4hbcq2h1BThb86vXp5waYKlHT05eq9XiZC9RzRm6f+C/xvm7KHJrOiUHs/8chpOY
	 aP+rLt6AsiKtFMDSzMc8dd89vy95ahoKFs1ml+OvYfHPn/gUVvVE07cJzk/wI+JdVSK6EhZEHx4h
	 yFDvxHN7Iwc3MdYWz+QGCemrDvqAr3MVnKTRTP6IIFv8DDg3EaLws5Lpmyudw1t4ufqlOpIqtaUW
	 n7SfZN0ZQ=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: kvalo@kernel.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	srini.raju@purelifi.com,
	syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: plfxlc: remove assert for mac->lock
Date: Tue, 30 Jul 2024 19:46:50 +0800
X-OQ-MSGID: <20240730114649.498184-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <877cd39nhg.fsf@kernel.org>
References: <877cd39nhg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 13:35:07 +0300, Kalle Valo wrote:
> > syzbot report WARNING in plfxlc_mac_release, according to the context,
> > there is not need assert for mac->lock.
> 
> The commit message should explain _why_ the assert is not needed.
> Otherwise it looks that you are randomly removing it to get rid of the
> warning.
mac->lock is used to protect mac data, but after calling plfxlc_mac_release(), 
there are two functions:ieee80211_unregister_hw() and ieee80211_free_hw(),
there is no action to operate on mac data in these two functions, so mac->lock
is not required.

On the other hand, there is no holding action for mac->lock before calling plfxlc_mac_release.

--
Edward


