Return-Path: <linux-wireless+bounces-590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF380B4F7
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 15:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA7B281044
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D14156D2;
	Sat,  9 Dec 2023 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="vCck6eHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB21A1
	for <linux-wireless@vger.kernel.org>; Sat,  9 Dec 2023 06:52:30 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w1.tutanota.de (Postfix) with ESMTP id B8245FBFBB0;
	Sat,  9 Dec 2023 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702133548;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=Gll/RqUz1mfkVWyJMSAnuRgfMhbKh/u2uOJ94ql/M9k=;
	b=vCck6eHAmrZXjhKNcav43DHKGNkcAaXmLz79nJi48FwM2Owdv3FxTLoxz+AnRFMX
	DCMptmkQApY6Gm2TY4MiD+yDn3d3/l4Afaxr9eQwkjpXGWdrOX0mSUanlpGuxrPMGoM
	nm9VsAXp0RWi2B7t2/2pW8rmpr+2CohYU4AzvB9dL9wqVuhAbqRdcIx45ehyPmr2LrL
	vy7FyjYL0moYwAccFQuYtj3XFVADW+9MQqJyUdcQxuXEKZ08bDTm0IEoYCsUFeRWgEi
	4gLSVEAsqOryf9HTlO86iisgUkG/Edh8zcc+G1XzOkazRyWyuc3VtsTwmaHr3xz/6V6
	Bp85c0NIiQ==
Date: Sat, 9 Dec 2023 15:52:28 +0100 (CET)
From: marco.rodolfi@tuta.io
To: Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Pkshih <pkshih@realtek.com>
Message-ID: <NlE3B0K--3-9@tuta.io>
Subject: Wireless P2P support for rtw88 families cards
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have seen in the past that this feature was already requested and Ping-Ke was trying to see what was needed to be implemented. I also have seen that this has been implemented in rtw89 family of drivers around one year ago.

Is there any progress on this feature?

