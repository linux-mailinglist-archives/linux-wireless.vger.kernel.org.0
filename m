Return-Path: <linux-wireless+bounces-39014-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FXj8HC7pVWp0vgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39014-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:45:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47647520A7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:45:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=meta.ua header.s=mail header.b=CgmA6oG1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39014-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39014-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=meta.ua (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D1B4301413C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850E3B8922;
	Tue, 14 Jul 2026 07:44:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxs2.meta.ua (mxs2.meta.ua [194.0.131.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A22DB7BD
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 07:44:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015071; cv=none; b=BYCPc3rxMzGqryi9c5aB8r2GyBFhRI5HOowONixDS3Dm1MtDqSyGjp3Y9ztjWufwcAvw2t5lIBeK+V2DS19zg1pLTT5z6KMj/D5EQrPHELTI75zoKoOWPN8WVHHb7N7+Ede9gmVk2S7crrolAtcAbTYe+VQ+fMLioZnmvb6hnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015071; c=relaxed/simple;
	bh=CGIA2b8VVmuOx8ikveP3bcf/O+15i9BfBHmAkLgVBCM=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type; b=htI5f3iRBqtCxR9wfcnl6ILYBBnisRkeN5AyXYhuFCir2F5gEAgRNBXB2BqfxqF9CZfeezkqSTUcXloT4coM3BtCw8C1m0he7qZ9E3pQlVhaqnDj9sIp+DN5tYInAcZOFe5vNhcbPOVGv+qvuHzu2VE95yHWpkbu936HwHknIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=meta.ua; spf=pass smtp.mailfrom=meta.ua; dkim=pass (2048-bit key) header.d=meta.ua header.i=@meta.ua header.b=CgmA6oG1; arc=none smtp.client-ip=194.0.131.3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=meta.ua;
	s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:Cc:To:
	From:Subject:Date:Message-ID:Sender:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Vu7tMDh+hyGXe1mtCCC9wzVvrkvdBl3/KuK0YMVgM74=; b=CgmA6oG1ZD9rlwV2fYPiWy2sOG
	QG23syQydXJ0h4SgUdry4F+/WC/CoZcEAly5L1J5tvbGdwIxU4IfceEhSOMw1Typ7HSw9mmOoauKn
	xXb6/IKfwZgMETB2rLr7xjOzHZHaio/YjO/Hnvwjhi2ri3bUKCGzkGlgv+RY4QfUnfLu99lIr0wq3
	5QvqE24sjJ0Bn0SxAh12jixJyd2HNdGepcIQX4NhnbXHEU4NhlH418mhLzSZQPn/L9zkh2C8tjRq1
	qcpLib/MmDzCUPvD1zIZgyGSQYuf8FOaKTx2YFzX7cPzoyUaRa/kudoGdw+1i8f2sYOFUsT+dchAs
	oeHNfksA==;
Received: from 185.222.23.114
        (MetaMail authenticated user nurofen55@meta.ua)
        by mail.meta.ua with HTTP;
        Tue, 14 Jul 2026 10:43:10 +0300 (EEST)
Message-ID: <60828.185.222.23.114.1784014990.metamail@mail.meta.ua>
Date: Tue, 14 Jul 2026 10:43:10 +0300 (EEST)
Subject: [BUG] rtw89: 8852be intermittent 2.4GHz packet loss regression
 7.0.12 -> 7.1.x
From: nurofen55@meta.ua
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com
Reply-To: nurofen55@meta.ua
User-Agent: MetaMail/1.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
Importance: Normal
X-Browser: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like
 Gecko) Chrome/150.0.0.0 Safari/537.36
MetaPassport-Id: 11250186
X-HddSpool: 1
X-Gen: 0078195ddc5d4f825a8f28daa7541649
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[meta.ua:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[meta.ua : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-39014-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,opensuse.org:url,meta.ua:from_mime,meta.ua:replyto,mail.meta.ua:mid];
	FORGED_SENDER(0.00)[nurofen55@meta.ua,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[meta.ua];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[meta.ua];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nurofen55@meta.ua];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nurofen55@meta.ua,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.ua:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C47647520A7

Hi,
I'd like to report a regression in the rtw89 driver (RTL8852BE) affecting 2.4GHz stability, introduced somewhere between kernel 7.0.12 and 7.1.x. This was originally filed on openSUSE bugzilla (bug 1271359), and Jiri Slaby suggested I forward it here for visibility with the driver maintainers:
https://bugzilla.opensuse.org/show_bug.cgi?id=1271359
Summary:

After updating from kernel 7.0.12 to the 7.1.x series (tested on 7.1.2 and 7.1.3) on openSUSE Tumbleweed, intermittent connectivity issues appear specifically on the 2.4GHz band. On kernel 7.0.12, both 2.4GHz and 5GHz bands were equally stable at the same physical location. On kernel 7.1.x, the 5GHz band remains fully stable at the same location, while the 2.4GHz band exhibits intermittent high-latency/packet-loss events.
Hardware:

- Laptop: Lenovo IdeaPad Slim 3 15ARP10

- CPU: AMD Ryzen 7 7735HS

- Wi-Fi: Realtek RTL8852BE (rtw89_8852be), PCIe

- Firmware: rtw89/rtw8852b_fw-2.bin, version 0.29.29.18 (9e3d777f) - unchanged throughout all testing (ruled out as a factor)
Steps to reproduce:

1. Boot into kernel 7.1.x (reproduced on both 7.1.2 and 7.1.3)

2. Connect to the 2.4GHz SSID at a location with moderate signal (around -70 dBm)

3. Run continuous monitoring (mtr/ping) while using the connection normally

4. Intermittent packet loss / latency spikes occur; the same location/conditions on the 5GHz SSID show no such issue
Captured evidence of one event (kernel 7.1.3), mtr output during the drop:
HOST: localhost.localdomain    Loss%   Snt   Last   Avg   Best  Wrst  StDev

1.|-- 192.168.0.109            20.0%    10   3018.  958.6  9.0  3018. 1234.6

     192.168.0.1
A single packet showed about 3018 ms latency with 20% loss recorded during the sample.
Notably, no corresponding entries appear in dmesg/journalctl during this event - no deauth, no driver error, no firmware timeout. iw dev wlp2s0 station dump immediately after showed the link as fully healthy: 0 tx retries, 0 tx failed, beacon loss 0. This suggests the packet loss happens at a level not surfaced by driver logging (possibly interference handling, channel contention, or power-save logic specific to 2.4GHz), rather than a link-layer disconnect.
Expected behavior:

2.4GHz stability matching kernel 7.0.12 behavior (equivalent to current 5GHz stability on 7.1.x).
Actual behavior:

Intermittent high-latency/packet-loss events on 2.4GHz only, with kernel 7.1.x; not reproduced on 5GHz under the same conditions; not reproduced on 2.4GHz under kernel 7.0.12.
Additional info:

Kernel 7.0.12 is no longer installable via zypper in the current Tumbleweed OSS repo, so I'm currently unable to do further direct A/B testing against 7.0.12 - this report is based on testing done while 7.0.12 was still available. I understand older builds may still be available via download.opensuse.org/history if a fresh comparison is needed.
I'm happy to test patches, run bisection guidance, or gather any additional debug output (debugfs, ethtool stats, etc.) if that would help narrow this down.
Thanks,

Sviatoslav


