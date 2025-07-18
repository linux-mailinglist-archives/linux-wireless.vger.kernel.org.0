Return-Path: <linux-wireless+bounces-25673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D12B0A9F0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 20:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE0A7A3634
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9072E7178;
	Fri, 18 Jul 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S8ipk19X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88F1799F;
	Fri, 18 Jul 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861808; cv=none; b=ZSa3TDHcoQ+f/p2zI0PbR6F8n8Ef8Svndr27H2Bnxbvgm1wx+rgfuxFn+CL49hPmczVi3eAsgSROmdxwjM2vzGjSpuv/mK2nQbuuqKirwahU/DkH6lKjfgFK5Iq0mgAQ6maYWMhzZ1SDQS7v653Bk6ZsLp9FIWTnZNP8C68j6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861808; c=relaxed/simple;
	bh=KFKBL9lxu9qRH0uSM7O9Zi7SITZuQeQ43sS4hJNZllQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rh7f8FmVtoF9yP218lLpCVjDvBmk43pIGfN6t7kvvugO/ekfLDDzXRoUNBcXBAMr7kG4KW5j9IVGE5IH7Qh3JGtC5uJfyapizdPq3teWDqQXRX2v80opVwdUvp5nFYMjtLgMvukz1/ZQ2xsblX/q9qfmi5CqrEK0peZQrNhonsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S8ipk19X; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CTATvulFqJ/iDBKnDw6rem6MuwIVbUfJ3v7HDdYiJto=;
	t=1752861807; x=1754071407; b=S8ipk19XzR3bEd4Q4LEICTuFg+HlQKgpOyr9l4e1sxqvUwx
	O7tk+5YOFwZpid7IRtPIfleZTUOrdrwO0d8w7SSNYQsbKp60WdGr5qhd6zezGLLfSdLxmmZvGBSw5
	O3XH9p+LDjAaN5cKnDErYuI+5dULJgG2wfkXb68U1NI4LeSJjvaAGAI34RyBTJhmwAVKIXo3Z7tAa
	LVwNJ9EZhzr4baapLJHd5QaUShYk9zbVGQ4qUxLjaqMIwEX7tgzVyf8qol1Mctes6dmryvGC3DXhx
	m3o9u/QtZoLkygHBfSnhEuE/1LTL8dWO4/x//FMatQqM7DAKEzG9Zmim9Dsosjkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucpQT-0000000D2pj-3LuU;
	Fri, 18 Jul 2025 20:03:17 +0200
Message-ID: <753bc16161f9f1024d33b93d6aa984c0b6adf51d.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless] BUG: unable to handle kernel paging request
 in ieee80211_wep_encrypt
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-wireless@vger.kernel.org
Cc: syzbot <syzbot+d1008c24929007591b6b@syzkaller.appspotmail.com>, 
	ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, 	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tglx@linutronix.de, 	x86@kernel.org
Date: Fri, 18 Jul 2025 20:03:16 +0200
In-Reply-To: <2d1a41aa000c8de8f82827bd8c06459e01f10423.camel@sipsolutions.net>
References: <6878cd49.a70a0220.693ce.0044.GAE@google.com>
		 <20250718145049.GA1574@quark>
	 <2d1a41aa000c8de8f82827bd8c06459e01f10423.camel@sipsolutions.net>
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

On Fri, 2025-07-18 at 17:57 +0200, Johannes Berg wrote:
> On Fri, 2025-07-18 at 07:50 -0700, Eric Biggers wrote:
> > >=20
> > > BUG: unable to handle page fault for address: ffff8880bfffd000
> [...]
> > > Call Trace:
> > >  <TASK>
> > >  crc32_le_arch+0x56/0xa0 arch/x86/lib/crc32.c:21
> > >  crc32_le include/linux/crc32.h:18 [inline]
> > >  ieee80211_wep_encrypt_data net/mac80211/wep.c:114 [inline]
> > >  ieee80211_wep_encrypt+0x228/0x410 net/mac80211/wep.c:158
> [...]
> > >  nl80211_tx_mgmt+0x9fd/0xd50 net/wireless/nl80211.c:12921
> >=20
> > syzbot assigned this to the "crypto" subsystem.  However, the crash
> > happened in crc32_le() which is not part of the crypto subsystem.  Also=
,
> > crc32_le() is well-tested (e.g. by crc_kunit), and the bug is unlikely
> > to be there.  Rather, the calling code in ieee80211_wep_encrypt_data()
> > is passing an invalid data buffer to crc32_le().  So let's do:
>=20
> Agree, that makes sense, looks like we never check the frame length
> correctly. Since there's no reproducer (yet) I guess we won't be testing
> against it with syzbot though :)

Well, hmm. So we're in

int ieee80211_wep_encrypt_data(struct arc4_ctx *ctx, u8 *rc4key,
                               size_t klen, u8 *data, size_t data_len)
{
        __le32 icv;

        icv =3D cpu_to_le32(~crc32_le(~0, data, data_len));

with presumably data/data_len being garbage. Via

int ieee80211_wep_encrypt(struct ieee80211_local *local,
                          struct sk_buff *skb,
                          const u8 *key, int keylen, int keyidx)
{
        u8 *iv;
        size_t len;
        u8 rc4key[3 + WLAN_KEY_LEN_WEP104];

        if (WARN_ON(skb_tailroom(skb) < IEEE80211_WEP_ICV_LEN))
                return -1;

        iv =3D ieee80211_wep_add_iv(local, skb, keylen, keyidx);
        if (!iv)
                return -1;

        len =3D skb->len - (iv + IEEE80211_WEP_IV_LEN - skb->data);

which _looks_ OK at first, however, looking at


static u8 *ieee80211_wep_add_iv(struct ieee80211_local *local,
                                struct sk_buff *skb,
                                int keylen, int keyidx)
{
        struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
        struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
        unsigned int hdrlen;
        u8 *newhdr;

        hdr->frame_control |=3D cpu_to_le16(IEEE80211_FCTL_PROTECTED);

        if (WARN_ON(skb_headroom(skb) < IEEE80211_WEP_IV_LEN))
                return NULL;

        hdrlen =3D ieee80211_hdrlen(hdr->frame_control);
        newhdr =3D skb_push(skb, IEEE80211_WEP_IV_LEN);
        memmove(newhdr, newhdr + IEEE80211_WEP_IV_LEN, hdrlen);

        /* the HW only needs room for the IV, but not the actual IV */
        if (info->control.hw_key &&
            (info->control.hw_key->flags & IEEE80211_KEY_FLAG_PUT_IV_SPACE)=
)
                return newhdr + hdrlen;

        ieee80211_wep_get_iv(local, keylen, keyidx, newhdr + hdrlen);
        return newhdr + hdrlen;
}


there's no check that the skb->len is actually >=3D hdrlen(), in which
case we would return an 'iv' that's outside of [skb->data..+len].

Then the

	len =3D skb->len - (iv + IEEE80211_WEP_IV_LEN - skb->data);

subtraction could underflow and result in this issue, I guess.

But the stack dump is strange in that we appear to get here via
nl80211_tx_mgmt() which only accepts management frames, but
ieee80211_tx_h_select_key() at least for WEP will NULL out the key for
!data frames, and then we can't get into the encrypt functions. Data
frames are always built by the kernel itself, so shouldn't get into some
kind of weird "header is shorter than the frame" situation.

It's theoretically possible that this is a _different_ frame being
dequeued than was just enqueued, but that seems like quite a stretch
since we just immediately dequeue after the enqueue with the hwsim
implementation ... and I'm not sure where that frame would come from
anyway.

So right now I have no idea what's going on here, nothing seems right.

johannes

