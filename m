Return-Path: <linux-wireless+bounces-35772-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ftXhCDsu9mmHSwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35772-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 19:02:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899E4B2F0C
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC6430097F4
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326BB28C2A1;
	Sat,  2 May 2026 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bToRYB1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE4155C97
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741368; cv=none; b=KBZlFQiD5Mp+g7gud7xYw42x2Meww6UWjCHMC9se1EfKd9YE25HfsIXK4rY7Vyp665yqk5Ynnal7puBwnm+Sgbe1zkgfv57UvckSk/0SqPBcnw2prsRqTtBXYNxiZxaiYeYqY1TMcOq2z2vHZbDlyKj8H+fKN8sIHq5HVVr9cPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741368; c=relaxed/simple;
	bh=VriAp7foZmsCBzHErYGHVXgwk9LudvrUIJpK0IpR+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VVxXFOrsrKB0yJTYwG0KCdImrNkgOrHTaM4U1hz6WxDvcqGlHkbyujobN5fjhcu50j5pZG2+4xUsAoEV891bnjOVVuznLlQTsI0VylZvTXwWSQmx1wWpgg+tBaFXa1JepdZiD04E8BNFnkmXwvd2FQ5FQwRUxJFPUXvwY1HZqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bToRYB1K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b150559bso18463195e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777741365; x=1778346165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzZgdwNJdhU6FxCtJG+UDhVcrXtg6d879KRoARyawaI=;
        b=bToRYB1KObhjwUjVQQ53j+W+xcllW+yrh5axchLhSjbjUb8ZwhRA9fagbAyqBXNdgZ
         488ickF0Znzgs7EqEn7MP5ZklQgDz7kukNtTZ+1dd9ee6VWJAhd3y4N2WOUFeD8N0Nru
         BW6fwE3NY43Op6r978/3MDlZh6dTTiWDloWKH9oi75J+e8ock9+haQGcV7YaSaLBHDDi
         u+DGpZhoTszi0a0ilbresYdtWZxruR1xV+8xS9TuENO7zrudn/QYNc0u/obSw3WMJHTa
         G6W383orRv9hYTS976KTv9sDqfhgFhiWzIEL4nGeowH3LORgeI+K4Sh/5SuCJSdQeO3U
         jPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777741365; x=1778346165;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzZgdwNJdhU6FxCtJG+UDhVcrXtg6d879KRoARyawaI=;
        b=Df+VKiZ18ACm22iH4QFfRoMD7MAEujXT87WfgW0mLh9jmRE46uMrCwuRPvp08X3va0
         EvmZUv6aj+k5oZYmG5QLQDiEKVh47nu9vQAtiIPcKoT8WvcYpg90nT+zoWPBkR9OyzRI
         HfaB/lWb+v1leoUy9GDOuJMjHUpMLLXT11ffuLyal9rWJjTqXJPp0MmbTUw1Yzdk7wVR
         TGtn2uUn7m4/IpSkro9TvFCijSzB5xMIBvJT0huaqnQCz1tMMyS8KTqUiPhhb/Pw/nT1
         qwRNJ+kcQsJDx+BIqVRqkS6OFknQG8JaY3Gl025TIUGXbW7Er1mH6fzfNr9cT0TKNC7S
         GbJw==
X-Forwarded-Encrypted: i=1; AFNElJ+rBKVF86mpKwH95sTS6f1v92ENK3UqK1suVI0XIMriyiL7o+uAY01HVVW2Bo0gwSRn/rrbTBzGfy4hMNku3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh8qOIbb5pnZuYJSiS6zajIdox7xVFMEk7//g7lRIAir9AX/0q
	lAAOhntsiPcH21q3fpIf8lYN7YlVa9pC9YAy0lnAhAs4O4aGbfPlDahs
X-Gm-Gg: AeBDietTvOiRn+BQR4Ym/dxY/2V6ujLhHdoMJUG0KLfOsUr3SwtbqbSUdom+6ePy0T/
	HuhVCJKc//Rsv8FusUpODG0bgptOVDzyCSa4r1FGt8eNbB0CSDBIGFwFt03fDxoolElgifwplom
	5daRcV2EdXTiBcPEYSpkuBvX7ZwbjEro1OGabUL3TcwaU0Y+D/u+cXAAqP9taV2Bsn28eAvKI7q
	pZO58X9dvNzo82fKIL+wFFfGGaj/d4iQwn+fMYidowV4AmhmNzy88CO+Q00MXWcDkdi/obLBgev
	uIbqeua7FsKXnGEm1wXHDbYRF/beTYY5vJzBo0xf+mOyUEomqZtHbVPZFmKpj5pDalht2xL6gll
	9ellmPU4QHUJ9UYuWhURhKptU6Kyc0V4pMYqQCTPg4RY7LXUlPm+Wl1zjBXCLWzR9XSIBBw268q
	LjWTtjhj8U6aubjmnnMKFTwvxJwEI2Sg==
X-Received: by 2002:a05:600c:620c:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48a98670f8emr57099515e9.24.1777741364564;
        Sat, 02 May 2026 10:02:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe92924sm38292845e9.2.2026.05.02.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 10:02:43 -0700 (PDT)
Date: Sat, 2 May 2026 20:02:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Tristan Madani <tristmd@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 2/2] wifi: libertas: fix OOB read from firmware
 bssdescriptsize in scan response
Message-ID: <202605030019.lL8x0ZPx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421135027.357622-3-tristmd@gmail.com>
X-Rspamd-Queue-Id: 5899E4B2F0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35772-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:mid,intel.com:email]

Hi Tristan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tristan-Madani/wifi-libertas-fix-OOB-read-from-firmware-pkt_ptr-offset-in-RX-path/20260423-061353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260421135027.357622-3-tristmd%40gmail.com
patch subject: [PATCH v3 2/2] wifi: libertas: fix OOB read from firmware bssdescriptsize in scan response
config: i386-randconfig-141 (https://download.01.org/0day-ci/archive/20260503/202605030019.lL8x0ZPx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9065-ge9cc34fd

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202605030019.lL8x0ZPx-lkp@intel.com/

smatch warnings:
drivers/net/wireless/marvell/libertas/rx.c:77 lbs_process_rxed_packet() warn: potential user controlled sizeof overflow '((p_rx_pd->pkt_ptr)) + 22' '0-u32max + 22'

vim +77 drivers/net/wireless/marvell/libertas/rx.c

69f9032d9dfeb7 drivers/net/wireless/libertas/rx.c         Holger Schurig            2007-11-23   57  int lbs_process_rxed_packet(struct lbs_private *priv, struct sk_buff *skb)
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   58  {
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   59  	int ret = 0;
6f93a8e7e41c2d drivers/net/wireless/libertas/rx.c         David Woodhouse           2007-12-10   60  	struct net_device *dev = priv->dev;
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   61  	struct rxpackethdr *p_rx_pkt;
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   62  	struct rxpd *p_rx_pd;
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   63  	int hdrchop;
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   64  	struct ethhdr *p_ethhdr;
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   65  
7919b89c8276d6 drivers/net/wireless/libertas/rx.c         Holger Schurig            2008-04-01   66  	BUG_ON(!skb);
7919b89c8276d6 drivers/net/wireless/libertas/rx.c         Holger Schurig            2008-04-01   67  
6f93a8e7e41c2d drivers/net/wireless/libertas/rx.c         David Woodhouse           2007-12-10   68  	skb->ip_summed = CHECKSUM_NONE;
6f93a8e7e41c2d drivers/net/wireless/libertas/rx.c         David Woodhouse           2007-12-10   69  
d2ed2703cabd1e drivers/net/wireless/libertas/rx.c         Dan Williams              2014-05-22   70  	if (priv->wdev->iftype == NL80211_IFTYPE_MONITOR) {
d2ed2703cabd1e drivers/net/wireless/libertas/rx.c         Dan Williams              2014-05-22   71  		ret = process_rxed_802_11_packet(priv, skb);
d2ed2703cabd1e drivers/net/wireless/libertas/rx.c         Dan Williams              2014-05-22   72  		goto done;
d2ed2703cabd1e drivers/net/wireless/libertas/rx.c         Dan Williams              2014-05-22   73  	}
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   74  
e45d8e534b6758 drivers/net/wireless/libertas/rx.c         Bing Zhao                 2009-04-06   75  	p_rx_pd = (struct rxpd *) skb->data;
                                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This comes from rx network data.

695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   76  
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21  @77  	if (le32_to_cpu(p_rx_pd->pkt_ptr) + sizeof(struct rxpackethdr) >
                                                                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This + operation can have an integer wrapping bug.

695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   78  	    skb->len) {
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   79  		lbs_deb_rx("rx err: pkt_ptr %u beyond skb len %u\n",
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   80  			   le32_to_cpu(p_rx_pd->pkt_ptr), skb->len);
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   81  		ret = -EINVAL;
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   82  		dev_kfree_skb(skb);
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   83  		goto done;
695347d07c2b05 drivers/net/wireless/marvell/libertas/rx.c Tristan Madani            2026-04-21   84  	}
e45d8e534b6758 drivers/net/wireless/libertas/rx.c         Bing Zhao                 2009-04-06   85  	p_rx_pkt = (struct rxpackethdr *) ((u8 *)p_rx_pd +
e45d8e534b6758 drivers/net/wireless/libertas/rx.c         Bing Zhao                 2009-04-06   86  		le32_to_cpu(p_rx_pd->pkt_ptr));
e0e42da3a4df6f drivers/net/wireless/libertas/rx.c         Holger Schurig            2009-11-25   87  
e0e42da3a4df6f drivers/net/wireless/libertas/rx.c         Holger Schurig            2009-11-25   88  	dev = lbs_mesh_set_dev(priv, dev, p_rx_pd);
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   89  
ece56191932623 drivers/net/wireless/libertas/rx.c         Holger Schurig            2007-08-02   90  	lbs_deb_hex(LBS_DEB_RX, "RX Data: Before chop rxpd", skb->data,
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   91  		 min_t(unsigned int, skb->len, 100));
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   92  
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   93  	if (skb->len < (ETH_HLEN + 8 + sizeof(struct rxpd))) {
9012b28a407511 drivers/net/wireless/libertas/rx.c         Holger Schurig            2007-05-25   94  		lbs_deb_rx("rx err: frame received with bad length\n");
bbfc6b788f63f0 drivers/net/wireless/libertas/rx.c         Stephen Hemminger         2009-03-20   95  		dev->stats.rx_length_errors++;
d2ed2703cabd1e drivers/net/wireless/libertas/rx.c         Dan Williams              2014-05-22   96  		ret = -EINVAL;
f54930f363113a drivers/net/wireless/libertas/rx.c         Philip Rakity             2009-04-07   97  		dev_kfree_skb(skb);
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   98  		goto done;
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10   99  	}
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10  100  
e45d8e534b6758 drivers/net/wireless/libertas/rx.c         Bing Zhao                 2009-04-06  101  	lbs_deb_rx("rx data: skb->len - pkt_ptr = %d-%zd = %zd\n",
a2caba6b5fc4e0 drivers/net/wireless/libertas/rx.c         John W. Linville          2009-04-14  102  		skb->len, (size_t)le32_to_cpu(p_rx_pd->pkt_ptr),
a2caba6b5fc4e0 drivers/net/wireless/libertas/rx.c         John W. Linville          2009-04-14  103  		skb->len - (size_t)le32_to_cpu(p_rx_pd->pkt_ptr));
876c9d3aeb989c drivers/net/wireless/libertas/rx.c         Marcelo Tosatti           2007-02-10  104  
ece56191932623 drivers/net/wireless/libertas/rx.c         Holger Schurig            2007-08-02  105  	lbs_deb_hex(LBS_DEB_RX, "RX Data: Dest", p_rx_pkt->eth803_hdr.dest_addr,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


