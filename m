Return-Path: <linux-wireless+bounces-6586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD68AB5FD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D7D1F21044
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 20:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5003E137C5A;
	Fri, 19 Apr 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=contac-dt.de header.i=@contac-dt.de header.b="IEebkXGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98813C9B4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558421; cv=none; b=CAqqOfULrRzBFkTv1duZk9gnspPhcMPpkWLTYGM7LoqzNEPoURi3x2AIah6YYX24eRTyizeB0R9XLi4ktdwQwxJoHPdeNX+JXraBuqzESxBQgnNZujKJ5XUUAxIE4MTzPHFbLFUtUkRSC98CjG7ynzdR+/kwWcU+oG3t+DvtgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558421; c=relaxed/simple;
	bh=BIIOwqfROR4JJ4dF+AZjHOhQSNcmvWd/lbzD6QYb6Tw=;
	h=MIME-version:Content-disposition:Content-type:From:To:Message-id:
	 Date:Subject; b=m7RKbEelceuP8rf4hBMxSHy2fzunCY5pZYUxSAPxvOtb6gsRKeeIEEDYsIhmczME3BdX+EL7gre2ZOI34QvwwWqK9oMJGwsJ5fFoEnyVL2BTb9PKtsKxmeoopKHZnVjDpoeTdHhdc5SXC6HeKIshzjZ6QPGEDjUB6JUSeLwBRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=contac-dt.de; spf=pass smtp.mailfrom=contac-dt.de; dkim=pass (2048-bit key) header.d=contac-dt.de header.i=@contac-dt.de header.b=IEebkXGU; arc=none smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=contac-dt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=contac-dt.de
Received: from 217.119.193.163_.trendmicro.com (unknown [172.21.19.72])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id AA1E9100269B7
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 19:57:44 +0000 (UTC)
Received: from 217.119.193.163_.trendmicro.com (unknown [172.21.197.65])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id D1913100004E4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 19:57:36 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1713556643.902000
X-TM-MAIL-UUID: 053df8db-ab82-47b2-9578-ad778378b28e
Received: from webmail.contac.lan (unknown [217.119.193.163])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id DC5FD10006A75
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 19:57:23 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-type: text/plain; CHARSET=US-ASCII
Received: from contac-dt.de ([172.16.1.96])
 by webmail.contac.lan (Oracle Communications Messaging Server
 8.1.0.20.20220923 64bit (built Sep 23 2022))
 with ESMTPA id <0SC7007FMGRNGR00@webmail.contac.lan> for
 linux-wireless@vger.kernel.org; Fri, 19 Apr 2024 21:57:23 +0200 (CEST)
Received: from [172.16.31.2] (Forwarded-For: 185.46.130.87)
 by webmail.contac.lan (mshttpd); Fri, 19 Apr 2024 21:57:23 +0200
From: Carsten Grzemba <grzemba@contac-dt.de>
To: linux-wireless@vger.kernel.org
Message-id: <bf57fa6d629f.6622e8c3@contac-dt.de>
Date: Fri, 19 Apr 2024 21:57:23 +0200
X-Mailer: Oracle Communications Messenger Express 8.1.0.20.20220923 64bit
 (built Sep 23 2022)
Content-language: de
Subject: RTL8188EU driver for Illumos
X-Accept-Language: de
Priority: normal
X-TM-AS-ERS: 217.119.193.163-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1023-28332.002
X-TMASE-Result: 10--1.586900-7.000000
X-TMASE-MatchedRID: L3XaisS8N+9IJ9jkRufYduT5AnjO7TXtXoNT4i7x/7fL4Mp4UvMNKdn9
	ehm9UmTN9MR66Vl9gxhRQwei528ufMuGaNHdfsZj4JrOTY8E3wvOYb2maDydwn6h5z50QYHFv4h
	Jwmdeepgnyb+F+dakoG7D4f3DwmBJnsFnw7zjyH9CPQBD3xA/3aryV/2jRq/X6eHzLh/npgivng
	kjHjojpJ/IGlj9P93lwIBc4C3fajAM/GHOyvHMegSXrcJGHda2cYO7LzLWqS51CBklKhESFC0Hp
	N0lIhdwae7iCy+osvRrbtJVlsw9xgmIQUwnapT5
X-TMASE-XGENCLOUD: 700fd5a6-ca42-4a2a-85e9-46da8c0c7f41-5-0-200-0
X-TM-Deliver-Signature: 9042572BCFF57B034DB2A2D225F0E154
X-TM-Addin-Auth: LT3lYX0TOBPn4iu+eCyT0BGeUTnapyVjBEtrLmObVVRFX99imN8Na9jFKNo
	IByQX/wWbRgc5gW5/Eu6j3T9Qoa2RA5XPOJQ2hPUkO6+8Ji96K7nFc+O1Zj/buPvRYEPYQwuF4O
	2lce6MSHWyRJ3+rw3Q9lwRNPFYJpZt+O7ztFiQ//jUiWDsnJnJTaRPgFrLncwx6qHxahJP2vhly
	WgMJYAINZXRE6lifm1FlpsBNRunejNZoYjKJl+qQ0piYHE19dK/2z84EMy6b8uelWC7yg==.i6j
	7OsH56TZBV9T40AniGK52smO/e5teFbm29pjclZVKoLt+2jFNP8aJurUZciT1f4f0VOdbsAvpfy
	KSh6pBI9pjRJEVCaYtLCMnNWLzGLG1kgPM2jK0f50t89jZl2JzuIyQ8DUT4BfoJuhHKtskx42fZ
	8pz+4knVSX7qPpcnIOFrlPnnF9amnxe1T5uwNA9T+6NwAjHCSBnADPwk8b4wBZczfMCPsta2CHd
	grytmDRaaZWDkSj1UK9lhd1Q7uJZA6EBDja3adpWq1310LoQZTze8ouCs9lm7HNHakh5yVXSq99
	xAxG5QsDqXA/d80NUWKGwX/BrBWUoxx5jY9lcdA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=contac-dt.de;
	s=TM-DKIM-20220607195629; t=1713556656; x=1714766256;
	bh=BIIOwqfROR4JJ4dF+AZjHOhQSNcmvWd/lbzD6QYb6Tw=; l=1254;
	h=From:To:Date:Subject;
	b=IEebkXGUkNlh8Wz+a4tsAM3bVvqeV+mAvT93qvUjKxX9wmmuyqJUL1ivPZ81QJIvq
	 EUO4VB0tcaAfytHkPYS/lMIabDVAa56sF4OgccQu+JI1mJSpzQiTsvM6sWNUJ7Qp7B
	 lFwSMZkkSl9ggSEEytcwklv1mUjqWYVLCcVr65DLO5xqgd6HZWGTNQBMW4c6p9RdfK
	 OHOxxa85L7t48u3pkwQlXHEhCSD7FJ6ZsnUpqUaH4TEusJl7b70SUIvPxbftd+QlF7
	 sXMaOt/hGTF7R0u8KV70HwWTsuOKnJ4BAAO+xvE6J55tHwI29DTE+4HGU21edNhNUI
	 P0Yn5BpnxkN0g==

Currently I try to create a driver for RL8188EU chip for Illumos.   As template serves    the RTWN driver of freeBSD   .   The starting base is the URTWN driver for RTL8192CU for Solaris from http://freenicdrivers.la.coocan.jp  . 
The driver works so far that WiFi scan and the registration to an AP works.   I see data packages arriving on the interface.  
 
However, no data package go outside, so that no IP connecting can be built up.    
   
It is strange to me that communication with the AP works, but not to other stations.    I suspect that the problem lies in the configuration of the TX descriptor.   However, I lack the knowledge of the meaning of the individual bits.   Is there a developer documentation for the TRL8188E chip public available?   
It s possible to check if the firmware can not interpret the TX descriptor properly?  
 
When comparing the descriptor with FreeBSD, different settings are noticed in DWORD5 (OFFSET 20) (data rate, RTS rate).   Can these be the cause of not sending the data packet?    
   
The current state of my work is avail at: https://github.com/cgrzemba/illumos-gate/tree/15014-urtwn-8188-3
   
I would be very happy if you could help me.   

   
Kind regards
   
-- 
Carsten Grzemba

