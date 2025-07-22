Return-Path: <linux-wireless+bounces-25873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9785B0E0F3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA241C25BDE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85329279354;
	Tue, 22 Jul 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eBP2stPY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84381E835C;
	Tue, 22 Jul 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199553; cv=none; b=HmmncWSsc3kmXFyiI+hViwGVltwwAlkKb4rJ2FWS84RZu2u3e92dnDq5DsD6D76YDo1YeuUI6nxRngMpoGvS7XONXdwvOhrIKp00x3h6Uj9Jhc1gNmiZD3ZekXw6jy3s9H/OpuoV6/YPh1wQq9abw/3qUbjBjjpi2wvtOYZq0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199553; c=relaxed/simple;
	bh=NKIckEBHqBmnJvHxD9TEvb7YwLSxeVHJM6pwdtCy+XI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ws6KDgMA5qdYoKeBwVygo/od6rLa3T8A6WPZK+aoXc/Ok3AyLcSv5ry7J0EeQ5/kNavy7nKNrhj+wt8F5yf6Pz8bRbaZrK11sQkye7OcN8wMKbilX5l+2NNWp7KR/zWHzrp/QmNmhNU33gbt3JiAftmmmYoR1fBfmr0xJIVqQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eBP2stPY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VnT1lsyxAx1cjwJoJ8JV0jArnRtTHaiwpHz8oLjh3zw=;
	t=1753199551; x=1754409151; b=eBP2stPYnnDtBx4AqjRy7LoCwq/rosDn41OZawPUd8rm0X7
	Kb47ZsUzr0Bu+Ks7Lilr0JSJIcxVVciSB9p/b1pD8lixfYwxvWnFGVdlfV4x1osdJ2Iq+n0wP6c9e
	WFgrESxtO5BcOMnxud256vjGJe6LAUSrjGZRMrwW+V8rkmGw8T86doGOpAhsPMhLjWADba3Mzjwys
	TSC5NB1aprbLWhyXbXDcFOW1OTuljSWFO+2Vo5iAPVFgbdy8J6RGf4wuyvp/1nTIlqwut/slbyTCd
	+YoqLzDuBhLrMY6fkJfaJc2ExIHClu32o6XZhzh0dbIHlTSqB3nl2axiKx5z93NA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueFI5-00000002Jtb-225B;
	Tue, 22 Jul 2025 17:52:29 +0200
Message-ID: <1dd41163c95eb818d13006ffc07b0815ce10b1ec.camel@sipsolutions.net>
Subject: Re: [git bisect] rsi_usb oops
From: Johannes Berg <johannes@sipsolutions.net>
To: Cameron Williams <cang1@live.co.uk>, linux-wireless@vger.kernel.org
Cc: regressions@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Date: Tue, 22 Jul 2025 17:52:28 +0200
In-Reply-To: <AM0PR02MB37936431F3602A64BAF8550DC46DA@AM0PR02MB3793.eurprd02.prod.outlook.com>
References: 
	<AM0PR02MB37936431F3602A64BAF8550DC46DA@AM0PR02MB3793.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> Commit 378677eb8f44621ecc9ce659f7af61e5baa94d81 ("wifi:
> mac80211: Purge vif txq in ieee80211_do_stop()") seems to
> have made rsi_usb/rsi_91x cause a kernel panic when
> removing the USB while the interface is up.

So it's been a while ... is this still happening?

> =3D=3D USB disconnected =3D=3D
> [   81.093884] [     T11] usb 1-2: USB disconnect, device number 4
> [   81.145395] [     T11] BUG: unable to handle page fault for address: 0=
00000009dff2338
> [   81.145637] [     T11] #PF: supervisor read access in kernel mode
> [   81.145868] [     T11] #PF: error_code(0x0000) - not-present page
> [   81.146096] [     T11] PGD 0 P4D 0=20
> [   81.146323] [     T11] Oops: Oops: 0000 [#1] SMP NOPTI
> [   81.146548] [     T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Kdump: =
loaded Not tainted 6.15.0 #1 PREEMPT(voluntary)  c74d5f1746d8801a78fe4695a5=
1ca9b00b89ab7e
> [   81.146790] [     T11] Hardware name: Dell Inc. Latitude E7250/0TPHC4,=
 BIOS A19 01/23/2018
> [   81.147026] [     T11] Workqueue: usb_hub_wq hub_event
> [   81.147267] [     T11] RIP: 0010:fq_flow_reset.constprop.0+0x12/0x140 =
[mac80211]
> [   81.147608] [     T11] Code: 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90=
 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 41 56 41 55 41 54 55 48=
 89 f5 53 <48> 8b 5e 18 4c 8b 3e 48 85 db 74 6a 4c 8d 6e 18 49 89 fc 49 39 =
dd
> [   81.148175] [     T11] RSP: 0018:ffffcb54c009b918 EFLAGS: 00010202
> [   81.148466] [     T11] RAX: ffff89629dff2328 RBX: ffff89629dff2328 RCX=
: ffff89628cb49210
> [   81.148757] [     T11] RDX: 000000009dff2328 RSI: 000000009dff2320 RDI=
: ffff89628cb489c0

This is just ... weird. RDX and RSI are pretty much holding truncated
pointers of RAX and RBX respectively? How does that happen?



The Code: seems to be the very first few instructions of

static void fq_flow_reset(struct fq *fq,
                          struct fq_flow *flow,
                          fq_skb_free_t free_func)
{
        struct fq_tin *tin =3D flow->tin;
        struct sk_buff *skb;

        while ((skb =3D fq_flow_dequeue(fq, flow)))

and thus of

static struct sk_buff *fq_flow_dequeue(struct fq *fq,
                                       struct fq_flow *flow)
{
        struct sk_buff *skb;

        lockdep_assert_held(&fq->lock); // not compiled

        skb =3D __skb_dequeue(&flow->queue);

and offset of queue inside flow is 0x18:

  18:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1d:	41 57                	push   %r15
  1f:	41 56                	push   %r14
  21:	41 55                	push   %r13
  23:	41 54                	push   %r12
  25:	55                   	push   %rbp
  26:	48 89 f5             	mov    %rsi,%rbp
  29:	53                   	push   %rbx
  2a:*	48 8b 5e 18          	mov    0x18(%rsi),%rbx		<-- trapping instructi=
on
  2e:	4c 8b 3e             	mov    (%rsi),%r15


I guess fq_flow_reset() didn't get inlined, but fq_flow_dequeue() did,
so that the calling convention uses RDI, RSI, RDX for =20

static void fq_flow_reset(struct fq *fq,
                          struct fq_flow *flow,
                          fq_skb_free_t free_func)

respectively, so RSI for 'flow', which matches the crash on
__skb_dequeue(&flow->queue) being=20

  2a:*	48 8b 5e 18          	mov    0x18(%rsi),%rbx		<-- trapping instructi=
on


But how did RSI get truncated? And free_func being such a pointer?


> [   81.151984] [     T11]  ieee80211_txq_purge+0x3f/0x130 [mac80211 43c49=
02366977cd272d3ef7b3fb48467d12f0d58]

calls it via fq_tin_reset():

static void fq_tin_reset(struct fq *fq,
                         struct fq_tin *tin,
                         fq_skb_free_t free_func)
{
        struct list_head *head;
        struct fq_flow *flow;

        for (;;) {
                head =3D &tin->new_flows;
                if (list_empty(head)) {
                        head =3D &tin->old_flows;
                        if (list_empty(head))
                                break;
                }

                flow =3D list_first_entry(head, struct fq_flow, flowchain);
                fq_flow_reset(fq, flow, free_func);


but that's about as far as I get ... I'm probably just chasing ghosts
and completely wrong about all of this...

> I have kernel dumps, vmcore dumps, whatever you may need,
> any help is appreciated!

If it still happens, I guess it might help to put some noinline
annotations on some of the functions involved to get a better handle on
what exactly is being passed. And run it in a VM ;-)

johannes

