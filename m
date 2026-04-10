Return-Path: <linux-wireless+bounces-34587-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGuxI8fs2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34587-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:27:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8D3D705F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FBF43072A86
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE03CF050;
	Fri, 10 Apr 2026 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM13lKS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105C3BFE40;
	Fri, 10 Apr 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823560; cv=none; b=KCohC9xR+GR/9Pt5RkH8cHDJxwjF9QkuoHHXN1azjakl/wjOaIDEQxkOqpe7xuA9PmAK8M7MJKiuUuD9SyrK+gZaiu67fpGLzQa9mH7NIWGuw62xhm6ZAtGpSvz2zGvLAtB/X0Bu2YXnGWkh+ZOt/6YJZPnUBuBu4xDqyyOc0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823560; c=relaxed/simple;
	bh=p4ul6fecafqSjuz/HWiW1SqReHpNi3SQC1heaf7AtH8=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=buCr1PgDuGE9ZEGgxhWb0EPGGGswBCZk02FAupQUqgmMbWtgzUmv0Nybucf2JEaGZ5znJIIfVK+JiFL91iXtgrrW5olYreoDWD9spHBNm7qtjuC6OB5dpRu/Nj8DVyzgmsS6ac0rItTn6CLsIvx2uk/WkPZBnDGjv/krom0Hrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM13lKS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E7C2BC87;
	Fri, 10 Apr 2026 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823559;
	bh=p4ul6fecafqSjuz/HWiW1SqReHpNi3SQC1heaf7AtH8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VM13lKS0vi1Fampzs2SOJUSl5pFNtZPRrbRXrfYUkEg7syYn7CVko7c7egIdexCfj
	 MaRLNlopnK85+N7I7i3OZHuHcMdHWNGNdlJV5bSYYI//COctIU1M1ukOOe7R86fGRN
	 QQ/j+jjVi+CYY1R1j+UlDL84K4FAOhCbq1OrkH36o+f5XviRftg90dsfUTYhZvjNV5
	 hk3/t6EuYClXGdWJA1CVm0r4gv7+Uuy+bWtd/uVuLx4/iO4+bV/Z+fKbXLcG7tmKkB
	 b/7xC9trAvx6oz1zNsW6Ny9Eav33gyvB9AokHXFATxUfQATArxGnp5TkYcwejIeG8o
	 hkZquPfDoH+3g==
Date: Fri, 10 Apr 2026 14:19:16 +0200
Message-ID: <20260410120318.253872322@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 10/38] arcnet: Remove function timing code
References: <20260410120044.031381086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34587-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 96E8D3D705F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ARCNET is a museums piece and the function timing can be done with
ftrace. Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: netdev@vger.kernel.org
---
 drivers/net/arcnet/arc-rimi.c  |    4 ++--
 drivers/net/arcnet/arcdevice.h |   20 +-------------------
 drivers/net/arcnet/com20020.c  |    6 ++----
 drivers/net/arcnet/com90io.c   |    6 ++----
 drivers/net/arcnet/com90xx.c   |    4 ++--
 5 files changed, 9 insertions(+), 31 deletions(-)

--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -291,7 +291,7 @@ static void arcrimi_copy_to_card(struct
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + 0x800 + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_toio", count, memcpy_toio(memaddr, buf, count));
+	memcpy_toio(memaddr, buf, count);
 }
 
 static void arcrimi_copy_from_card(struct net_device *dev, int bufnum,
@@ -300,7 +300,7 @@ static void arcrimi_copy_from_card(struc
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + 0x800 + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_fromio", count, memcpy_fromio(buf, memaddr, count));
+	memcpy_fromio(buf, memaddr, count);
 }
 
 static int node;
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -11,7 +11,6 @@
 #ifndef _LINUX_ARCDEVICE_H
 #define _LINUX_ARCDEVICE_H
 
-#include <asm/timex.h>
 #include <linux/if_arcnet.h>
 
 #ifdef __KERNEL__
@@ -62,7 +61,7 @@
 #define D_RX		512	/* show rx packets                        */
 #define D_SKB		1024	/* show skb's                             */
 #define D_SKB_SIZE	2048	/* show skb sizes			  */
-#define D_TIMING	4096	/* show time needed to copy buffers to card */
+#define D_TIMING	4096	/* Not longer supported. Use tracing instead */
 #define D_DEBUG         8192    /* Very detailed debug line for line */
 
 #ifndef ARCNET_DEBUG_MAX
@@ -95,23 +94,6 @@ do {									\
 		pr_cont(fmt, ##__VA_ARGS__);				\
 } while (0)
 
-/* see how long a function call takes to run, expressed in CPU cycles */
-#define TIME(dev, name, bytes, call)					\
-do {									\
-	if (BUGLVL(D_TIMING)) {						\
-		unsigned long _x, _y;					\
-		_x = get_cycles();					\
-		call;							\
-		_y = get_cycles();					\
-		arc_printk(D_TIMING, dev,				\
-			   "%s: %d bytes in %lu cycles == %lu Kbytes/100Mcycle\n", \
-			   name, bytes, _y - _x,			\
-			   100000000 / 1024 * bytes / (_y - _x + 1));	\
-	} else {							\
-		call;							\
-	}								\
-} while (0)
-
 /*
  * Time needed to reset the card - in ms (milliseconds).  This works on my
  * SMC PC100.  I can't find a reference that tells me just how long I
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -70,8 +70,7 @@ static void com20020_copy_from_card(stru
 	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
-	TIME(dev, "insb", count,
-	     arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count);
 }
 
 static void com20020_copy_to_card(struct net_device *dev, int bufnum,
@@ -84,8 +83,7 @@ static void com20020_copy_to_card(struct
 	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	/* copy the data */
-	TIME(dev, "outsb", count,
-	     arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
+	arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count);
 }
 
 /* Reset the card and check some basic stuff during the detection stage. */
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -332,15 +332,13 @@ static void com90io_setmask(struct net_d
 static void com90io_copy_to_card(struct net_device *dev, int bufnum,
 				 int offset, void *buf, int count)
 {
-	TIME(dev, "put_whole_buffer", count,
-	     put_whole_buffer(dev, bufnum * 512 + offset, count, buf));
+	put_whole_buffer(dev, bufnum * 512 + offset, count, buf);
 }
 
 static void com90io_copy_from_card(struct net_device *dev, int bufnum,
 				   int offset, void *buf, int count)
 {
-	TIME(dev, "get_whole_buffer", count,
-	     get_whole_buffer(dev, bufnum * 512 + offset, count, buf));
+	get_whole_buffer(dev, bufnum * 512 + offset, count, buf);
 }
 
 static int io;			/* use the insmod io= irq= shmem= options */
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -633,7 +633,7 @@ static void com90xx_copy_to_card(struct
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_toio", count, memcpy_toio(memaddr, buf, count));
+	memcpy_toio(memaddr, buf, count);
 }
 
 static void com90xx_copy_from_card(struct net_device *dev, int bufnum,
@@ -642,7 +642,7 @@ static void com90xx_copy_from_card(struc
 	struct arcnet_local *lp = netdev_priv(dev);
 	void __iomem *memaddr = lp->mem_start + bufnum * 512 + offset;
 
-	TIME(dev, "memcpy_fromio", count, memcpy_fromio(buf, memaddr, count));
+	memcpy_fromio(buf, memaddr, count);
 }
 
 MODULE_DESCRIPTION("ARCnet COM90xx normal chipset driver");


