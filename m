Return-Path: <linux-wireless+bounces-35773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOLzFs0u9mmHSwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 19:05:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBBC4B2F35
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A683009B2D
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C63859D9;
	Sat,  2 May 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApH0Zs8V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C346248891
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741514; cv=none; b=iT6pLzbj6gs/dfMj5A+TnTNsSd1VRltogQcwfclhGkBXhASVbQ9BlM5v+iooheOVzW0CxxS4p9lW0vviYiK/EBoPqN1HpRqk36hhJVG5+wcw+t/ypm3O3bjENgcdm1hTE+PGu8l/G+RiFHH5gf8vlCyuVgEkFzBYalbv88hT5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741514; c=relaxed/simple;
	bh=FdBVkyT70nLb57XfOr6JT3sFi3ZSJD39ANIk5R41Idk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTwkh9IpvOahL/X45FasTTPIU7LcvEFks1yMc/f9kysvilb4t6QKK5phQbogfRdWJtokbQU7S5PjXvPg9TfSiXMWkUpdbjabBGZyw5ButwAJeDwnpeY8/obyI2xI4tDvpAfVZ7xoIQnMmQHnTwDbx/2D1xVET3XSYyF059Im7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApH0Zs8V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-448528f4e69so1624602f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777741510; x=1778346310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OvxfOGDImPDEvap085cD/4NlYHfKvABsDFeu1Dgyuc=;
        b=ApH0Zs8VKCbZ4g/mJ+B18JMwlDoVw8pAJECOaLPaxDhx7D6UU0b06Zs0hcgTnKlaVY
         m8bjlG+VYzeNlljSnA6NZ1TDXc7Vd+Mlcbku53SlHHCoYuUR2xSfZ+4GgZ5fI2NCW6M8
         KyTNcjNtaUxcoV8sfwqMp8vJ7YaP3LfMo47hCBbPnzUE3HhxwiIxZrYMwEyewxC7+iO1
         +8yMxuwRleH99iafhALbhQ6eTKFhPN7mc177trCNaqRpk9qZDTx5/GBlnLFIcLvnqtln
         LWd6xMWkmKDt6Do1oB3UPbGR0Tnnm+WCMhrl62p9HO9xevVPBftiyWfg2EY38qKWuJNi
         CL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777741510; x=1778346310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OvxfOGDImPDEvap085cD/4NlYHfKvABsDFeu1Dgyuc=;
        b=rKSvOv5bLQaDQnzxUlXnRsi3zWNnsKUnqpyoXKjGvRS5ZET+4PSUrOfwFyThKnIwHv
         S5/WfT37jr/LELfnR5khxbDTyuyDt0QMU7nVhiYPTsrRWYM1PqzYntAiihy2hhs2vJyZ
         x/QokdYQb4Kw1b09eJD7AEi+ONFD/GesoekQJP/1hWiZAGNXCKV8oaShnfW0quYMisxS
         JVeFmr32Dr0OCsJlNclJH4x1pMgSG2H6gUopKr/Axxvk9vItHxgq6XbstFTqVbmjUhly
         32T23sYyXleG3ZYHyUJnRSYxBj4OXm9FY9kmWtpNhJ0CGJueIidz12p466Q2k+l9Tpc8
         F9sw==
X-Forwarded-Encrypted: i=1; AFNElJ+YDRyz2a6iRF6LfTL1bU3ws1xdDRD8cc4+UxQ4G1c45MGuZPdWyPdFUvrM4PNFmGPk7+X44+Y1sF6jnaS9CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXDBc8IJ4FLxOxJ/xzY4wvo3wwVHYnEhQ1ibfYQc3jmIBUvBm
	/ithPuHU6uQHyuo0DhimH0dVWOCKt4s8ECCgzkJuZu1nuhnpuHBZOv53
X-Gm-Gg: AeBDieuXeJalbA6hIsTjcNZZ6AVXV41RIEbolI3oJjQXNsqLb0IdAWUWV31Z4Pttg/E
	nbI8zccQJ6p8jOlB6yDDhoSxdkYyV3g08JChr5lzwI4Oh/VziJJrsY7s1xJWPKCZ99b8zgK39sq
	WZrLv7hFTCaGyITncy9wcrvly3UWBspul4MoxzqWQV43KPBB9/0xQTGCVi+JmfTZJBMYb2yPzyf
	YDZRGjus6LNURYOj8bi+UuAv/SrR0APDu4SjlVLkpk17Itt1V3Z4TsnoyhVwN2Bbi2cmHwoe5LJ
	Nclv8syKvdVFQ09+rwujMytnLCxH2mCs7LcV0F7Yt09WcSWme0NlxZoGCKKzu+WPEMr7rrh+224
	xi8gXC/v+p8ea776wFbA5urD3evsS5VYPkqUwWj1TW+5qjV1pQEWu6Mt0e1VWuu8YyWd5WTDAon
	hNjGECtIed/KDEXE9QWOdRAwRts86Fmw==
X-Received: by 2002:a05:6000:1acf:b0:441:2473:c30a with SMTP id ffacd0b85a97d-44bb5c425d4mr5958184f8f.31.1777741510282;
        Sat, 02 May 2026 10:05:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aaad6sm11422643f8f.28.2026.05.02.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 10:05:09 -0700 (PDT)
Date: Sat, 2 May 2026 20:05:05 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Tristan Madani <tristmd@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 2/2] wifi: libertas: fix OOB read from firmware
 bssdescriptsize in scan response
Message-ID: <afYuwVf23vKag2XA@stanley.mountain>
References: <20260421135027.357622-3-tristmd@gmail.com>
 <202605030019.lL8x0ZPx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605030019.lL8x0ZPx-lkp@intel.com>
X-Rspamd-Queue-Id: AFBBC4B2F35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35773-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lists.linux.dev,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]

On Sat, May 02, 2026 at 08:02:39PM +0300, Dan Carpenter wrote:
> Hi Tristan,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Tristan-Madani/wifi-libertas-fix-OOB-read-from-firmware-pkt_ptr-offset-in-RX-path/20260423-061353
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> patch link:    https://lore.kernel.org/r/20260421135027.357622-3-tristmd%40gmail.com
> patch subject: [PATCH v3 2/2] wifi: libertas: fix OOB read from firmware bssdescriptsize in scan response
> config: i386-randconfig-141 (https://download.01.org/0day-ci/archive/20260503/202605030019.lL8x0ZPx-lkp@intel.com/config)
          ^^^^^^^^^^^^^^^^^^^
Of course, it can't wrap on 64 bit systems.  But just do

	if (size_add(le32_to_cpu(p_rx_pd->pkt_ptr), sizeof(struct rxpackethdr)) > skb->len) {

I don't know if anyone uses this hardware on 32 bit systems but we may
as well do it right.

regards,
dan carpenter


