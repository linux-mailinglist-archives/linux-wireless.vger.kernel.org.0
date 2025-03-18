Return-Path: <linux-wireless+bounces-20495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EEDA67556
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 14:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399F87A28C1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83ED148827;
	Tue, 18 Mar 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="asv/mvU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0120C470
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305225; cv=none; b=chtFa3Bnt2EKmCyVZCKlMdx5aQLwT8HyNJ0Woj4T9W3OEzyGOrSKQuS0mCy1emHSrNx6J/Ne1+lDZClEik78Zslhb0XdSppJvttB8dQtjg3B91yvRb6no8FQ6twuyathO/jRFhKXnVJ8u+EaIvaA8+RqRtdR1rd77MBzKxynSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305225; c=relaxed/simple;
	bh=4GTnRkCrbpmyHi8zaZpK9BLvWBMQzoWqoJ9TgrjRbcc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Tdllabe6odjUhLcOHGqNJQGCEnGOBPaJbRfo5QkCxYKsiTmuanQIyKPMSS3ZC4S65i0Hj5/gFZ+bEHGU5MGISB9hbRbIpWVgFa4ocJB7GVu1VGWbonHMQ8RJFVxK3qfgARlDVXcSabvmS4mFhFms5M7XyWrWoDQ8ssxNssqhn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=asv/mvU2; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 28D912FC0190;
	Tue, 18 Mar 2025 14:40:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1742305219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eq/ebP2CwM8wTQ/fwb2hWC6lSTwZgA4O8KrnlqmEgmU=;
	b=asv/mvU2GdoK+zoyUo++r/22A6/BQ+1ibi6sY0mldkBVFa1zwoUySI6f0ZBoGNlNvRSgl2
	yRyturHQY963jQjLs84wafwaG1JmDH/RCeJkqUnjxGD6TXYyDfG54KkQb0LA7h4TnKhI2Y
	5RiBWxoDXFLy3Ndyp2Y2R377mme9nAc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <398de7cb-e455-4cb4-98e8-31471bb740a6@tuxedocomputers.com>
Date: Tue, 18 Mar 2025 14:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-firmware@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Christoffer Sandberg <cs@tuxedocomputers.com>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Georg Gottleuber <ggo@tuxedocomputers.com>
From: Georg Gottleuber <ggo@tuxedocomputers.com>
Subject: [PATCH] ath12k: WCN7850 hw2.0: update board-2.bin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Added an additional board string with qca-swiss-army-knife:
bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,
qmi-chip-id=2,qmi-board-id=255

Tested with 2.4GHz, 5GHz and 6GHz (iperf3 -t30 --bidir)

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
---
 ath12k/WCN7850/hw2.0/board-2.bin | Bin 1986952 -> 1987068 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/ath12k/WCN7850/hw2.0/board-2.bin
b/ath12k/WCN7850/hw2.0/board-2.bin
index
48f18e23014c4a8d1d771c4bd1ed1ceda00a33ef..659acff5411e6f10accbf227b46088fa83ec0291
100644
GIT binary patch
delta 89
zcmV-f0H*(lqj~(Jd4PlggaU*Egam{Iga(8Mgb0KQgbIWUgbaiYgbsucgb;)ggc5`k
vgcO7ogcgJsgcyVwgc^h!v>f=90qB>ptr1g~OqCpV0WpV9l^nNEl^r>}c)}mC

delta 87
zcmV-d0I2``qj`v<d4PlggaU*Egam{Iga(8Mgb0KQgbIWUgbaiYgbsucgb;)ggc5`k
tgcO7ogcgJsgcyVwgc^h!v>f=90d$wKtr1g~OqCpVhc=cRw>Fj?#=AG9A7=mn

-- 
2.43.0


