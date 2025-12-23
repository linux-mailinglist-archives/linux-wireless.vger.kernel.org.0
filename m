Return-Path: <linux-wireless+bounces-30073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63F9CD7FC8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956BE301174D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EC2D8DD9;
	Tue, 23 Dec 2025 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="f1l4cRZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF382D8DC3;
	Tue, 23 Dec 2025 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461465; cv=none; b=AiGwkb84XeZfV/S+8u299BrgjiJLjUSPGD4EGpdEfro7UnasBxINpKGH8giu7kWrYJnHHfbFJ6K8Hb4OrFNnROSVJ4bdFfdLXLQNTbxKxiRqr6CzAXhGisJbf3nl3FW45hTxtk707t9w6enUvNnnrCS8qTxwFl0OlOFhSFcVlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461465; c=relaxed/simple;
	bh=SPCXi2uhdtiEs2IxMZzeLU8TNozhmScd1qfRSYWegiE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=OFMx+W1rwCbTytZhakKE3T2+IxvfVXcSIVVZw7+tD5ETOU21CfaP04W6dlY19GRP6p+iOpR41FUQCUqOV3jQXcYgGNGWBeWuvSc8nZfiXI/gsEj47ncFxAMlcNsRdbcL5kc6dGHBsfebREWrJCl7lVgQRom8iHzRyvXLdAgL5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=f1l4cRZW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN3iDr25625364, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766461453; bh=LZrSoc6eb8aLhZ1nOyfCWELFrsxslFnXs5qKPAZBSiI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=f1l4cRZWjThu0vOuNmA2vuux2+qCGm/JeZIbGCWLFnBM+jJeNTw2IIIO560q1/jit
	 6YRg33mX2hbKvQ5Xi87Tq4dAVOSv26uE/09NtaCYOMHV8KxkITpr+5wbtK8JIqwM1M
	 0gMXX1QSC3DADeav3KaXcX60jAcdKkBrDy5dxTBIYbCyy1uhN7xgH/3pn7eh6G+zp2
	 Hsfa/gCwYXDPSxQrcsaQ/cBQkQfWN5AFcBDCGtwaIjWhUdHvJK1ke5rO4gl8q0Y99+
	 +DeFcK0k/MChyVeywXNELcmPYpAAjz2GVLnn/tlv2SQW1xD44nNTJfqwn2wXP0aNnC
	 oPNhGKs7fWhyA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN3iDr25625364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:44:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:44:13 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:44:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:44:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: Re: [PATCH v2] wifi: rtw89: 8922a: set random mac if efuse contains zeroes
In-Reply-To: <20251126091905.217951-1-jtornosm@redhat.com>
References: <20251126091905.217951-1-jtornosm@redhat.com>
Message-ID: <0df9e1e3-c8de-4e0b-8f0c-95ac64b11e9b@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 23 Dec 2025 11:44:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> I have some rtl8922ae devices with no permanent mac stored in efuse.
> 
> It could be properly saved and/or configured from user tools like
> NetworkManager, but it would be desirable to be able to initialize it
> somehow to get the device working by default.
> 
> So, in the same way as with other devices, if the mac address read from
> efuse contains zeros, a random mac address is assigned to at least allow
> operation, and the user is warned about this in case any action needs to
> be considered.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

41be33d3efc1 wifi: rtw89: 8922a: set random mac if efuse contains zeroes

---
https://github.com/pkshih/rtw.git


