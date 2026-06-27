Return-Path: <linux-wireless+bounces-38203-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p4N5H8XUP2rUYgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38203-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 15:48:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F270F6D20A8
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 15:48:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R4I6SCRx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38203-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38203-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0388D3005D2F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BF3AE71F;
	Sat, 27 Jun 2026 13:48:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA372D12EC
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 13:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568124; cv=none; b=c/sPXfF0hfwppR9lRCNRcKM5nK7q/p8b0S+LL5Bh9IyQAXS197RbkZdGQ272RWQ8fWVuGmDVO18Po2IASiZGrs/Cf7t8+Ty1Y7faGjF6EbN6kyDSTYS/S+Zhdmk1zeWMOdVBDjWDp5v05BTwf3MFOHddHkQWXDe0ykME5uKclsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568124; c=relaxed/simple;
	bh=a1iESqEKzeEW2QdxjA3qBQJ0ILFoeM3R0WmjgJRpJPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHj+Wmza8EpV0F5CrfLsHhGHDyBK1ue9GkJ3wV8AAF2LMgOcgN/Tp3F390Cfy+DNDYciqsQS8C+nY+paVl2gnWTH1khbHaizDU9bPKfiKIGDtKTsdMpncZAa9z/KsqYR9nIYymqydtEgf4Ewc2vT5PWbGzNAQfNpZcXhyNJ+tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4I6SCRx; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7cfa17fe0so9741675ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782568121; x=1783172921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqdjV5oDnFfNzgOSWSCE1f39mTL2dsZjhBz4Y4Dx96U=;
        b=R4I6SCRx868Yjn9AmupxVNUDkUNh1BP2q38VyHFZ2iFT9AFoNMLWgRFqmTStVFkNVy
         +7CcZl/1RInKldWnjoaMAVx5y7eXaedAEUtDpaWJZ756QXufv3qBWcxp9ZhcgoOgRYl/
         5xoIBLz8KVn0WaCcHBy08h5zGHUlHi2j9itRXZIOqhWy4/pFolgGj7lDvoZjC5HhAeDU
         h4J/xMTG8UJaq0IX2vF0qzw28VFlEPWuiRZa+gRCz1rET9O1cqDCgHq6jlNZ5FrM+J8M
         qNk9XjYsRnb2vtQueMyZQFYUJhW4FF+5ORKEO3SIUhQENYV5Sd5+cHoNsysj/xkGdJYq
         0T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782568121; x=1783172921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqdjV5oDnFfNzgOSWSCE1f39mTL2dsZjhBz4Y4Dx96U=;
        b=iF0DCPex3Gizqiw0XIwxv8kgjinKzN2IHRUMhA5YKXRQ1ybrPtvdp1h+dnaeRyBQ76
         Gvk0RRoCkXDl39E20+kito3ptfLdYkCl24uK4HuF9wrQOuEvaZvSxNxIi/Td4DG4Umba
         WGYBq2tEcfWttuGXqpFai6yW05MfmNX79eR2YzNNi4+R1A/qnosTfQ+D4WVgNzKAN+hh
         6tx8kp22mqohoiqHEoSojV8DIrHx2rtRDP5YXgBkV+DKCBsfTGnSpKaoWWWYoW1Fxrc0
         5NYL3SFNoK4NAj47fG29tpMCDgNJrJb+ssCLhFKtrI0LVXrCb4vqbC9cLG6KuxIwxQBN
         MDWA==
X-Forwarded-Encrypted: i=1; AHgh+RoURFZiZJmCspJEhEGwbcV4dTiUkYHqrfL84L0JMCTlXevBUr9GY4yxN3P3Bf9tEtmjEoUFEsL7ewd5j23+oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfx10ulwK14V/V2Zcj4jCSwZEzSy0p2l1GftZHq0B08b/hCqMS
	WhNCblcY++FJUSVTyF9GE5vC4K/XNnNe9Ny+4wdA2hxoUEYsaP59FP4NfOm3fV3lt859Cw==
X-Gm-Gg: AfdE7clUYk9QRyPRZE36q2IisHpQeS4oGiKp9DrTbEpgNskSIVSKGYbS799jx3hf9nA
	sRH+RcXyoImMsUDZcUS7HktRG9Ez+jK41uqoQPniEKOV6rIcDi9CnvY+RPQtW0zUHaw8MWaxoMV
	egLxXSTRvSG38OymfSOXCRnLhi0rj4hZtmqjo9cmpon9Zaj6Egbwo+OAMCp3MTXE4QonlqAriXs
	4hUwPBjjgMoNbm/XYIcEyFVUZ5gZR9LqxUE4MHrVUKJHn258oI5YmgJTClUScTn2lrfcooBXP0G
	tj+p2Y1ZroxsSzKMQ2oUSfs96sb2gKx0ZcwkmPI+H2WYlr5VGZl7xthwj1+BX/tBmiZLBKkR05l
	OdAi+/bcfAKoBht1MAO8TI2+SIVsCrnaGgiRBrOjcG1TOBIQq+5XrYdQKOyS/Pwe5/n0nyzMxyB
	IMsdvdzn0PfAH3+JXsLGiQhIZHLrg=
X-Received: by 2002:a17:903:8c6:b0:2c1:150d:6db5 with SMTP id d9443c01a7336-2c7fc62db0cmr102496435ad.6.1782568121329;
        Sat, 27 Jun 2026 06:48:41 -0700 (PDT)
Received: from localhost.localdomain ([112.166.204.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afdd40sm58372515ad.33.2026.06.27.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:48:40 -0700 (PDT)
From: Hojun Choi <ghwns6743@gmail.com>
To: serhatkumral1@gmail.com,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: benjamin.berg@intel.com,
	miriam.rachel.korenblit@intel.com,
	linux-kernel@vger.kernel.org,
	syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,
	Hojun Choi <ghwns6743@gmail.com>
Subject: Re: [PATCH] wifi: mac80211_hwsim: avoid division by zero in mac80211_hwsim_write_tsf()
Date: Sat, 27 Jun 2026 22:48:27 +0900
Message-ID: <20260627134827.12531-1-ghwns6743@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625215606.11049-1-serhatkumral1@gmail.com>
References: <20260625215606.11049-1-serhatkumral1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[ghwns6743@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-38203-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:serhatkumral1@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:benjamin.berg@intel.com,m:miriam.rachel.korenblit@intel.com,m:linux-kernel@vger.kernel.org,m:syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,m:ghwns6743@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghwns6743@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,21629c14aa749636db9d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F270F6D20A8

Tested-by: Hojun Choi <ghwns6743@gmail.com>

Thanks for the fix. I confirmed it with a standalone reproducer that
injects a beacon on a monitor interface with a radiotap MCS index past
the band's n_bitrates. The bitrates[] read then goes past the table but
stays inside struct mac80211_hwsim_data (so KASAN is quiet), lands on a
0 .bitrate, and write_tsf() ends up doing 1920 / 0.

Without the patch:

    Oops: divide error: 0000 [#1] SMP KASAN PTI
    RIP: 0010:mac80211_hwsim_write_tsf+0x476/0x5e0
    Call Trace:
     mac80211_hwsim_tx_frame_no_nl
     mac80211_hwsim_tx
     [...]
     ieee80211_monitor_start_xmit

With the patch applied, the same injection no longer crashes (tested on
mainline, 502d801f0ab0).

The commit message explains why ieee80211_get_tx_rate() itself isn't
changed (ath5k/adm8211 and others dereference it without a NULL check).
Is hardening those callers, so the index could be bounds-checked
centrally, worth doing as a follow-up -- or is the per-driver guard the
preferred direction? Happy to help with the legwork if it's useful.

Setup and build:

    iw phy phy0 interface add mon0 type monitor
    ip link set mon0 up
    iw dev mon0 set channel 6
    cc -o repro repro.c && ./repro mon0

(mon0 must be on a live channel, or the frame is dropped before xmit.)

The syzbot dashboard has no reproducer for this bug, so here is a
standalone one:

/*
 * repro.c -- divide error in mac80211_hwsim_write_tsf
 *
 * write_tsf does 1920 / txrate->bitrate for a beacon. The bitrate comes from
 * ieee80211_get_tx_rate(), which indexes bands[band]->bitrates[idx] checking
 * only idx >= 0 -- never idx < n_bitrates. A radiotap MCS index past the table
 * reads an adjacent slot in the same heap object (so KASAN is silent); when
 * that slot reads 0, the divide faults. We sweep 12..127 (8..127 on 5/6GHz).
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <endian.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <linux/if_ether.h>

enum
{
	Rtmcs	= 0x00080000,
	Havemcs	= 0x02,
	Beacon	= 0x80,
	Burst	= 32,
};

typedef struct Frame Frame;
struct Frame
{
	unsigned char	rtversion;
	unsigned char	rtpad;
	unsigned short	rtlen;
	unsigned int	rtpresent;
	unsigned char	mcsknown;
	unsigned char	mcsflags;
	unsigned char	mcsindex;
	unsigned char	rtpadend;

	unsigned char	fc;
	unsigned char	flags;
	unsigned short	duration;
	unsigned char	da[6];
	unsigned char	sa[6];
	unsigned char	bssid[6];
	unsigned short	seq;

	/* beacon body -- tsf's end (32B) clears the write_tsf length gate */
	unsigned long long	tsf;
	unsigned short	interval;
	unsigned short	capab;
} __attribute__((packed));

void
die(char *s)
{
	perror(s);
	exit(1);
}

void
fill(Frame *f)
{
	memset(f, 0, sizeof *f);
	f->rtlen = htole16(12);
	f->rtpresent = htole32(Rtmcs);
	f->mcsknown = Havemcs;
	f->fc = Beacon;
	memset(f->da, 0xff, 6);
	memset(f->sa, 0x02, 6);
	memset(f->bssid, 0x02, 6);
	f->tsf = htole64(0x05e6b0);
	f->interval = htole16(100);
	f->capab = htole16(0x0021);
}

int
main(int argc, char **argv)
{
	char *iface, *colon;
	int fd, kmsg, lo, hi, idx, i;
	struct ifreq ifr;
	struct sockaddr_ll to;
	Frame f;

	iface = argc > 1 ? argv[1] : "mon0";
	lo = 12;
	hi = 127;
	if(argc > 2){
		colon = strchr(argv[2], ':');
		lo = atoi(argv[2]);
		hi = colon ? atoi(colon + 1) : lo;
	}

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if(fd < 0)
		die("socket");

	memset(&ifr, 0, sizeof ifr);
	strncpy(ifr.ifr_name, iface, IFNAMSIZ - 1);
	if(ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die(iface);

	memset(&to, 0, sizeof to);
	to.sll_family = AF_PACKET;
	to.sll_ifindex = ifr.ifr_ifindex;
	to.sll_protocol = htons(ETH_P_ALL);

	kmsg = open("/dev/kmsg", O_WRONLY | O_CLOEXEC);

	fill(&f);

	/* the injection: send a beacon at each MCS index, sweeping past n_bitrates */
	for(idx = lo; idx <= hi; idx++){
		f.mcsindex = idx;
		if(kmsg >= 0)
			dprintf(kmsg, "repro: mcs=%d\n", idx);

		for(i = 0; i < Burst; i++)
			if(sendto(fd, &f, sizeof f, 0, (struct sockaddr*)&to, sizeof to) < 0)
				die("sendto");
	}
	return 0;
}

