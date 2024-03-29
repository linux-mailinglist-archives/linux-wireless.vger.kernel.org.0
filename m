Return-Path: <linux-wireless+bounces-5680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4689351D
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B0D28CBE9
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B945148FE9;
	Sun, 31 Mar 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="RFrhwXw2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5026148FE1
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902563; cv=pass; b=qitpXnQfM1xGkI0cgzhK7IHH+tHH8CO0vbsLnJ3vy0+KwvE2F80Rm7Pae2Q4wVP8LwU31Bznac757KrArR3ceCw+UF0g1afCVH24zWgapEoi6pHsj+dWPr+6uoORy+nf8MNP1hHdzhfgV6/tS9P2kxXxuq5r9oL23hSkNZ7xI/w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902563; c=relaxed/simple;
	bh=ItmHfWjLdvsILXfC8TgEB70myvuqlP3W2q10z6vMhGw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ki95Zg3J267y0Rv2Gfm+MnHvdsL3MerILztnHq8FYO3R/MMgP1eV8rl64Fq3Al/qiLqroav4LDe8h1Ppv8oznOlJHHeoI7IG5dlYkrvc8Fdh4yv90SFbXKMmkFUZW6rsG9p0+dYe8xbQPIVGw0+eCaj/LpI/ozG7ukCdpXFQVVA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=fail smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=RFrhwXw2; arc=pass smtp.client-ip=96.47.72.81; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=FreeBSD.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6DC3F208E4;
	Sun, 31 Mar 2024 18:29:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCsUyx5CqbSG; Sun, 31 Mar 2024 18:29:20 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EF319208D4;
	Sun, 31 Mar 2024 18:29:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EF319208D4
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id E304080005A;
	Sun, 31 Mar 2024 18:29:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:29:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:35 +0000
X-sender: <linux-wireless+bounces-5628-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAhZPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBhAAAAjIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 15818
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5628-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4250C20883
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752057; cv=pass; b=HQ9Rf4GXMGmZmX0/vX1fUMjwcKfJ4V8qgVXJ8xH0k7pngTQOIh+sYt/qOZ34zT/13DI7mVQ3iGOsKCgN7X5IWwvE3dHwwS8ZNFEKWu96j+KesOiDebD0VN05LYSjR29TXU5QyHLtjgn8UzFJcyS6O2s+yK5EvraSiqMt89ev7bc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752057; c=relaxed/simple;
	bh=ItmHfWjLdvsILXfC8TgEB70myvuqlP3W2q10z6vMhGw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=WaDduBwotT24gjzvbJ0mV3WCWCMic5it3SwDpuY/g8YEoVpAG0RKLB+raB6itaLVR5dDKJC4+vjmem0LYDQu4WPFTBIagNyt0q1THsraIMdzyll0U8Y4stiSPFyByaLat/P3OycDTZpG+7txZ4AYi8u5O4r6r/UdTn12XW0muN4=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=RFrhwXw2; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711752055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gn7QOGXaVs/MtoXMsTH/aaRdzuSSvZ+fvGeeVoEHcI4=;
	b=RFrhwXw2sPyHbryVzZEcrhuaruF8U/aOPSsDTTU+pmznBA32uVnDUa3aT1nzASi1e6e3Ol
	IwlwB/rFMIVniqHHWfiMnXyhN2aqc8kG5zD72N1Atrfnv/7xHa0DgEMlBp7BP6ibMmeoNz
	uv7Ay7q8BvRNYlUjdnsEANz6516FC6GLenPPM2Z0x7ntd1T+/rc8gr5uzZ6QbemTvYi+/O
	/r4bLLaYSHten5OFp5J0qO8oF+C03qzNV8EGud7y/Zm+UDoRanVLS2KdOmNJv2jeCcXXQ1
	XZglQM7DLGTCq8HJv4F/dYafT5G6aA9YBg6+abV0qMt1cF9P/wzf6elJt+BokA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711752055; a=rsa-sha256; cv=none;
	b=UmEXp07ypsN0DLz9c8DP2aty0Nh7AWraLE1IFStNvavO0WlI3hrg4ARx7/QKtn+fOWlnSy
	9vEdzGvgee5qbOOw6sn5E7YMaRJcF+LNE67fTua+att+DLevykgmEPZA/kEj2lW8HxgecE
	L48E8kl3r09gkDi1g218YSN7bvTasd8+rrX/RZUC38puKjrTs+2OJUeJ9eJ9B+B1+qXoPF
	F7ZmOy7Fpu/YworeSNsfMryn7yieZxM6k5b28sLFrJynNgL+MZO3JxL+X8maE9M19/oRbK
	JLrhgEvIYc53lBkkUi4LOLEpICPvCrUIsKOMvHsVs4SbcE9kBlJxr0z0zE/gjw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711752055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gn7QOGXaVs/MtoXMsTH/aaRdzuSSvZ+fvGeeVoEHcI4=;
	b=LrZ9+MlAZmqPns3J7n6gVctDms5hjDm+a8sESfdUmookj3Q6d6cxSA9kGZ4ehxipsYx7aa
	2SkJ5HmRPgVLycje4L+3qv2M3dbgMALPvHDfARGJva7PXgRF6nQ2CZKlQwIXX4Oucq3hoN
	22Z51qXzuK0NTWcFFu6eYXTwZiMJsx4NhKvebCGqEeIsmlNl8pnPPfHzbDq89sNl0EQkZU
	iRLPhUu9Fkqmz9EknU8QHpgpYlt1DzXXgBzcwgEMBbbgA0YewPmsHIpwfFpIORQimnsDhq
	g6c1z/B+GGbERljetnt+gA1p671FQOzAvsRoN6CaZ63P4QJOkcfgRj1u05Y8Jw==
X-Virus-Scanned: amavisd-new at sbone.de
Date: Fri, 29 Mar 2024 22:40:52 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 2/3] wifi: iwlwifi: remove function declaration without
 function
Message-ID: <r4q0o9rs-0q52-5125-nro9-p37n72qnn86s@SerrOFQ.bet>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

iwl_trans_pcie_send_hcmd() is left without an implementation.
Garbage collect.

Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored by:	The FreeBSD Foundation
---
  drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 1 -
  1 file changed, 1 deletion(-)

diff --git drivers/net/wireless/intel/iwlwifi/pcie/internal.h drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 7805a42948af..22749a0de78a 100644
--- drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -552,7 +552,6 @@ void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
  int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
  		      struct iwl_device_tx_cmd *dev_cmd, int txq_id);
  void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans);
-int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
  void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
  			    struct iwl_rx_cmd_buffer *rxb);
  void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
-- 
2.40.0


