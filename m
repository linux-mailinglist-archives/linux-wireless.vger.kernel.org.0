Return-Path: <linux-wireless+bounces-26243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE71B201CC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 10:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6147ADE4C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED72DC32F;
	Mon, 11 Aug 2025 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="o4Dw0TcE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794C2DAFB1
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900746; cv=none; b=tUJWxa+EzB0+LCfNLU819wVz5qJuhEB3TOuPoUsXeyr33MhQX1svwzD5odq88KvZmy7dSZuvccdjpfx4fzAJJ0XvXE6gs7I469dUC2yABoTU6tUdtyJ8fAU6AnCe9YrUzFXY3Gz5dgdHMq3kEEGGCkgtDcOilXqFGBNJob4x0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900746; c=relaxed/simple;
	bh=wSVdEjNhr/Aedo4US0huJwXygfcimDIqqyJPM25g0pg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qyeJ5w/jYWP3p5A141dLItW/PNeQac4U/TiZTBosXkhpvcwxmq7V3BCkR+LnTVhMhlvxQlBu8hFZfKwVeq6+aQBJ44x4aT6zqA2cmvnL6rPL25EhHOGnBwlFWikJ9x0ZBkWH+a0fhP6PS/agaR8XoElkObaQUVevZ78DrBfAu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=o4Dw0TcE; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id lIlYuffHJcOgklNpAuDZAF; Mon, 11 Aug 2025 08:24:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lNp8uquA4GtD7lNp8u7lIi; Mon, 11 Aug 2025 08:24:07 +0000
X-Authority-Analysis: v=2.4 cv=aKjwqa9m c=1 sm=1 tr=0 ts=6899a8a7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=R1XpmoYe2GHAZdAE2O7VqQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10
 a=sqjRI6sB8JoUyLQipjQA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u4JWtZRbyFWsXDHN6TsKnpoMaDgKL7JaCPlC5vu8pVs=; b=o4Dw0TcE5Io821B62qIizWYDLv
	sACEJzZnKKe7ncoJvafS71caCcKiuTdfn/gfy5wNaoHdlqtH4TBNRk7u0aPx2CCz6M7K95GPIs0U8
	YyVsBqz7EmchDHOV5luNFrPcFdRdGQvQd+Qx72oP8M/mJlHlusewFUrmn41iKSqMyer+qG4Ab8Ls8
	lavTtyYwGnR+j+vsWw8ne5fm7YNVunjVegPwWJTfn0l0ccB1j9BpLFdSKVW437t51DmwspfXcd6zP
	yeB3pTm2uwmzniL7GduC14B86+vN2+b8vsoH4EcqjehshRjKTZpb2RZkVa1DAx1FB+h8k0TWzwrA9
	TG8W/y+w==;
Received: from oni-27.109.98-104.oninet.ne.jp ([27.109.98.104]:36622 helo=[10.249.161.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ulNp8-00000001rgg-0A1C;
	Mon, 11 Aug 2025 03:24:06 -0500
Message-ID: <fbc03dee-273a-4c75-a8bb-fbc6ae48d26d@embeddedor.com>
Date: Mon, 11 Aug 2025 17:23:56 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] wifi: iwlwifi: mei: Remove unused flexible-array member in
 struct iwl_sap_hdr?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 27.109.98.104
X-Source-L: No
X-Exim-ID: 1ulNp8-00000001rgg-0A1C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: oni-27.109.98-104.oninet.ne.jp ([10.249.161.44]) [27.109.98.104]:36622
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJWqk3q1BmRkgO8CKfZQjpjJl/wpPBGx9W57wmwDmYrVFrD2H40dG8NwMYrFSuygkZnDm1DZQebK4zYGag7IBXkRTO0U+r2WOiDUvcPy+01D3tXZ/+vk
 rZIG/y64c7CxQh3nV2BzV/s1f6Cn3ne1pd65duqMp1cCvZqzmmHoEUV63RRYBxwZj/gwEUEz7/VYqTncz4el3VEGhnM52UeZkS7IcpQRGBkFc+sGY2nwaq3s

Hi all,

At first sight, it seems that the flexible-array member `payload`
in the struct below it's not being used:

drivers/net/wireless/intel/iwlwifi/mei/sap.h:
298 /**
299  * struct iwl_sap_hdr - prefixes any SAP message
300  * @type: See &enum iwl_sap_msg.
301  * @len: The length of the message (header not included).
302  * @seq_num: For debug.
303  * @payload: The payload of the message.
304  */
305 struct iwl_sap_hdr {
306         __le16 type;
307         __le16 len;
308         __le32 seq_num;
309         u8 payload[];
310 };

If we remove it, we'd get rid of 14 of the following type of warnings:

drivers/net/wireless/intel/iwlwifi/mei/sap.h:318:28: warning: structure containing a flexible array member is not at the end of another structure 
[-Wflex-array-member-not-at-end]

Is there any case where this array is actually used that I might
be missing?

Thanks!
-Gustavo

