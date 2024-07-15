Return-Path: <linux-wireless+bounces-10225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2159313F1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464ED284705
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07E18A955;
	Mon, 15 Jul 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nC97rCNm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0B13B295;
	Mon, 15 Jul 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045840; cv=none; b=DrhOheXdkS9gHb5bWbC6sbhDIS05W/jGcGfp80cnzTdeprVe1wW+5xqlZcjpO4lpTEko5+QqwdCli0YWkVCAv75ut4GVSA/DLVPYsaIqfgfBScbLlMWp40Wr5pFHUFhbMv3xOKkxPYK/tM6wi5+9kF0EGiK1+mB2VSUvIvssLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045840; c=relaxed/simple;
	bh=IeyCAkzcfaio2u0NT/1xcLRfdWbeJnZKH5vasv/8NBA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rg0pKX9jHne7mJdRrmCtlO7wfXiONyM67CHxFhQi6I5v73X1sic/kXHsJRKW98QSlezdNKd1bqVLBx1IDzo7DC0JgDwAHt9AK/Cnusm2hlaqW/CPACEPArJe/P1jP8HTnpU+0DsGdcDzxTVMn/GtZWf72EijvRyxvgq0oABJuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nC97rCNm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721045818; x=1721650618; i=markus.elfring@web.de;
	bh=NB32WoDd06M/wpmpaHBsHqbVrbOZIfeBxzfCKnzXGoM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nC97rCNmJQqt85Z8n/lOr7jK4XS6BQ/ervO+pv3uLg0ZwzNARDMs1Vbb0/xTX9HI
	 sjs4xWU63k9LVCiTo039kYZEJgt/zabgBK0aCmdJi2C5HUVqR7Gf+D8g2GD7HDgeR
	 m5kw2uUQp8SBsvd2aKtiBLn4ruwiwefBvjNex884546qWA1NgNFm/fQyaZAY+YlAi
	 89m04zFNDcuJkg5HRhxuU9s1wbzUm9WZ66tiYtHJXKLk+KHQelnYjlpwSi0MuGyAW
	 aBlHDDPyNj74tSmeRQEk7UXNHjmwRVEJ7AtUQH5p/uZJvpL/zfzIFBRV5lvpTRix8
	 Suc0BS3ZrnVFJwKbbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1smf0G2LKo-00HcGU; Mon, 15
 Jul 2024 14:16:58 +0200
Message-ID: <38ae4f27-177d-40c3-a16f-c8bd286df13d@web.de>
Date: Mon, 15 Jul 2024 14:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Kalle Valo <kvalo@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] wil6210: Replace 8 seq_printf() calls by seq_putc() calls
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d0P9VkzMqi303zPg4KqBnTOMTfZU6XOfZr0Uhm6l9Le72R9I+b7
 ZE98vRqFPZ1jhzWvOchmqVvQ8HK3supTkIwoDPgGOZa0RHPI7y5b34FtYTRzZeBzi4SCWX1
 Ky0K1Uw50EdPj8TrKo3Bo+twHR/945QMDigBMlkwdAtT8peOOxh71uQ3byCu4MJ3wshBaax
 cgx1nC07Y1+kedGkwUILQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3xfTRa3X/ro=;3Sdtj9hz+pKZlMo5rKwRr/7NN+v
 ulBZqRorGvJOAqHAkSGZ64EYBcGOnDvNlY329L9gAGqvmnPpe67Pu5DPI20Fp2gze0zwJ+s3T
 rc0kQSeYO0DRSYp9Zw8AcluddH3SSlRZTxSjzTx9HRrE0eDm4UVXSCw5N4jtaI30A3K4vAOIN
 9WPEtzwI7wH7edX9zksQtBvGADGg+w+TeX2NnT08y2W+hXRcb3rAygyQKD+Q6ZX0UfoZ0NEH5
 vpXKjGhz9adxHGwxrd3ZO2i5F0qIPFlqViGGunvp2ldf21ghcF/ufftFVIYkNeVn2FjhdQCqU
 vmVOrR6u5wn/4PzCmwcqtRfyJb/sfaZz/vYT12SSpQw0Ccq4l9fzsU7hqBRH9fPiBUWjSxY4G
 qFZrBGlEKGepyJ4INIAHWiwcGXCLeGSc2VDlSszEgDZ7mBupRbyXPerpJFfxBxUxJ+DQD4x+Y
 U/fj2swvtiwgVvJKa60WZk6B9a6Aotn8p1rjGsasBuSvycMu/1XS57O6HpCXjeOlG0joN0Ih2
 21edYIPhadBqGZQIMz1InnD6qGOFlnYPfQZCYNNjhA2XRJ+8VJtgAjYDPc24QH3J+tFJhtHOc
 gwYrFyQH2b4CQLf9Ty0Jd3kgZdBUymO27CQ1ydWMgSlbcdkGqpG1mmzmyc0Ch8Lgc8VeJhvr8
 842tx91X4+xT53QKXpmTlU53iO32CB9R/22mUds8PHAi0X07lifBQcwQZeIYtxUHhfulwkNDf
 C9iSTRgS7PJc/GNNT48LJXAUa5D4ChHixTl2A2YzggE7jCJ0Pj4Jf8jiOrjK5khOZl8U4dW+M
 1tNbpNpzAS5BPrJs8HiFu2jg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 Jul 2024 14:09:01 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for eight s=
elected calls.

This issue was transformed by using the Coccinelle software.

Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/ath/wil6210/debugfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wire=
less/ath/wil6210/debugfs.c
index c021ebcddee7..6e16936631d5 100644
=2D-- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -55,7 +55,7 @@ static void wil_print_desc_edma(struct seq_file *s, stru=
ct wil6210_priv *wil,
 		if (wil->rx_buff_mgmt.buff_arr &&
 		    wil_val_in_range(buff_id, 0, wil->rx_buff_mgmt.size))
 			has_skb =3D wil->rx_buff_mgmt.buff_arr[buff_id].skb;
-		seq_printf(s, "%c", (has_skb) ? _h : _s);
+		seq_putc(s, (has_skb) ? _h : _s);
 	} else {
 		struct wil_tx_enhanced_desc *d =3D
 			(struct wil_tx_enhanced_desc *)
@@ -64,10 +64,10 @@ static void wil_print_desc_edma(struct seq_file *s, st=
ruct wil6210_priv *wil,
 		num_of_descs =3D (u8)d->mac.d[2];
 		has_skb =3D ring->ctx && ring->ctx[idx].skb;
 		if (num_of_descs >=3D 1)
-			seq_printf(s, "%c", has_skb ? _h : _s);
+			seq_putc(s, has_skb ? _h : _s);
 		else
 			/* num_of_descs =3D=3D 0, it's a frag in a list of descs */
-			seq_printf(s, "%c", has_skb ? 'h' : _s);
+			seq_putc(s, has_skb ? 'h' : _s);
 	}
 }

@@ -120,7 +120,7 @@ static void wil_print_ring(struct seq_file *s, struct =
wil6210_priv *wil,
 			} else {
 				volatile struct vring_tx_desc *d =3D
 					&ring->va[i].tx.legacy;
-				seq_printf(s, "%c", (d->dma.status & BIT(0)) ?
+				seq_putc(s, (d->dma.status & BIT(0)) ?
 					   _s : (ring->ctx[i].skb ? _h : 'h'));
 			}
 		}
@@ -237,10 +237,10 @@ static void wil_print_sring(struct seq_file *s, stru=
ct wil6210_priv *wil,
 			if ((i % 128) =3D=3D 0 && i !=3D 0)
 				seq_puts(s, "\n");
 			if (i =3D=3D sring->swhead)
-				seq_printf(s, "%c", (*sdword_0 & BIT(31)) ?
+				seq_putc(s, (*sdword_0 & BIT(31)) ?
 					   'X' : 'x');
 			else
-				seq_printf(s, "%c", (*sdword_0 & BIT(31)) ?
+				seq_putc(s, (*sdword_0 & BIT(31)) ?
 					   '1' : '0');
 		}
 		seq_puts(s, "\n");
@@ -1556,9 +1556,9 @@ static void wil_print_rxtid(struct seq_file *s, stru=
ct wil_tid_ampdu_rx *r)
 	seq_printf(s, "([%2d]) 0x%03x [", r->buf_size, r->head_seq_num);
 	for (i =3D 0; i < r->buf_size; i++) {
 		if (i =3D=3D index)
-			seq_printf(s, "%c", r->reorder_buf[i] ? 'O' : '|');
+			seq_putc(s, r->reorder_buf[i] ? 'O' : '|');
 		else
-			seq_printf(s, "%c", r->reorder_buf[i] ? '*' : '_');
+			seq_putc(s, r->reorder_buf[i] ? '*' : '_');
 	}
 	seq_printf(s,
 		   "] total %llu drop %llu (dup %llu + old %llu + dup mcast %llu) last =
0x%03x\n",
=2D-
2.45.2


