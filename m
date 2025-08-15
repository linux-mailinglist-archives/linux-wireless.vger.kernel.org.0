Return-Path: <linux-wireless+bounces-26403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15EB27EB8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 12:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183253AEFC0
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7FB2F90EA;
	Fri, 15 Aug 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="Qnzmt7t+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AD2FCC07
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255006; cv=none; b=u6k08tyHiNguKXgAn83jxp82TuV3GZNuBX5lA+gZrzicGypcs0CDr6lblSkEIZX08v/uwKqKk+cjiOpt0c11jKCZzQgXzfA+o3fp8CDlIpRzBvefIoebvOj/EtHKaT7Doa1yRq8ZpLMk9q4jiBo2QE2knQc3VZmk2YqVmpvuO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255006; c=relaxed/simple;
	bh=CYab7EsKk/l6a5apcJHMEhHZFSDP2DfGPh1VWRQn3/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STLHHrt/E0mnsv1ZIJXQc2MWOtfGfAkb9uHOpbMIKzG/VRw83bH/8DSyhLCk1+wFEi2c839aF4L9Dmxg/bZBfpTAJSWHS8V6NSuQdIiuE6D0OZxMKc8XrXIF5BW04C/s4SYnWiiz5zNvmHOwCREWZ/41ckqnDBQRQ1gI/Nh4aOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=Qnzmt7t+; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:41772 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1ums0X-00000000536-0wF6;
	Fri, 15 Aug 2025 12:50:01 +0200
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
	BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
	CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
	HTML_00_01 0.050000, HTML_00_10 0.050000, IN_REP_TO 0.000000,
	LEGITIMATE_SIGNS 0.000000, MSGID_SAMEAS_FROM_HEX_844412 0.100000,
	MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_FUR_HEADER 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, SENDER_NO_AUTH 0.000000, SINGLE_URI_IN_BODY 0.000000,
	SUSP_DH_NEG 0.000000, URI_WITH_PATH_ONLY 0.000000, USER_AGENT 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CP_URI_IN_BODY 0.000000, __CT 0.000000,
	__CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000,
	__FROM_DOMAIN_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_REFERENCES 0.000000, __HEADER_ORDER_FROM 0.000000,
	__HIGHBIT_ASCII_MIX 0.000000, __HTTPS_URI 0.000000, __IN_REP_TO 0.000000,
	__MAIL_CHAIN 0.000000, __MIME_BOUND_CHARSET 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MOZILLA_USER_AGENT 0.000000,
	__MSGID_HEX_844412 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SINGLE_URI_TEXT 0.000000,
	__SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
	__SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_ENDS_IN_SLASH 0.000000, __URI_HAS_HYPHEN_USC 0.000000,
	__URI_IN_BODY 0.000000, __URI_MAILTO 0.000000, __URI_NOT_IMG 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __URI_WITH_PATH 0.000000,
	__USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.8.15.95719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=Clxuag8DPQyWryjyc1kmj+AUwV3NpiSsh6+EWAw8Fak=;
	b=Qnzmt7t+jLcTLK26nOUlTyEvLYABIhbzOPXYMRvJzUQ3B7A2/tt8CgTjrwxNKX9fu2VzpgBQFGt+Q5rjmK+tkM6IGIX7Dw9aEZlHbCcJbEjvEuISoOeAne4Nj2JZK8pQuPwAVGTw6vU69RkKJdr5mu6WXdd0wU59x9SCekAqUiw=;
Message-ID: <5ce28473-0fab-4fbe-9668-0042ff7d86c4@dd-wrt.com>
Date: Fri, 15 Aug 2025 12:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: ath12k: REO status on PPC does not work
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <573c76a8-c2a0-4b9c-b5a8-762b8d094b81@dd-wrt.com>
 <aJ8LYj+NGaX8cwge@FUE-ALEWI-WINX>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <aJ8LYj+NGaX8cwge@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1ums0W-000Aoo-4E
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1ums0W-000Aoo-4E; Fri, 15 Aug 2025 12:50:00 +0200

i just can say. the changes i had to make for ath11k to get big endian 
somwhat working where massive. alot of endian handling in ath11k is 
simply not considered. the firmware is little endian and alot of fields 
must be converted to host endian order. but at end end i struggled with 
dma transactions and gave up since it was not resolvable. the patch i 
made for ath11k was massive at the end and ath12k is not much different
technically ath11k and ath12k can be merged at the end. i dont know why 
there are 2 drivers maintained which are technically very similar at the 
end. alot of patches for ath12k can be applied to ath11k which i do 
sometimes if its a usefull patch. but ath11k itself is abadoned for 
maintainance as it seems (at least if you look for qualcomm supplied 
patches)

Am 15.08.2025 um 12:26 schrieb Alexander Wilhelm:
> Am Fri, Aug 15, 2025 at 11:55:14AM +0200 schrieb Sebastian Gottschall:
>> i played already with big endian platforms and ath11k (not ath12k) for
>> months. there is also a problem with the dma descriptors. the firmware
>> simply doesnt support big endian with host communication at the end even if
>> there is a endian flag for the firmware.  dont get into this rabit hole. (i
>> worked 3 months on it and gave up)
>> at the end (i was working on a cavium octeon platform at that time) i just
>> switched the kernel boot to little endian which is possible on many ppc
>> platforms too.
> The 'ath11k' driver works a bit differently. The endian swap is implemented in
> the firmware and was never properly tested. My investigations show that the
> firmware does not handle the swap consistently. According to 'kvalo', different
> firmware versions treat the swap differently. See [1].
>
> With 'ath12k', the situation looks better. Unfortunately, there are still some
> memcpys from u32 to u8 or similar. Also, reading from DMA memory is not swapped.
> I already have ath12k running, I get ping responses and can transmit data.
> However, not in all modes, and there are still some bugs I’m trying to iron out.
>
>
> Best regards
> Alexander Wilhelm
>
> ---
> [1] https://lore.kernel.org/ath11k/68290980-5bfb-c88c-be78-954f9591c135@westermo.com/T/#u
>

