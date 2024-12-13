Return-Path: <linux-wireless+bounces-16351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD209F0464
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 06:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4EA1684CE
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818EE18C03D;
	Fri, 13 Dec 2024 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJuqp3yV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D618C03B;
	Fri, 13 Dec 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734068852; cv=none; b=mopV+fsubHJ0KYJYkid2FLqvPsq2hHY3ItWHfpegS1xsScjP1QeSptk7NmWbWcBs9RMdMnWXDKPZntjRa325nN0evyb5nbnrI+aJRSUw/P8w1XDmGuCYcTIKZXjxHCzzlaaHkR2ojm/6XMLU7ud9uM46cJfvUCKpHTqHOJNMwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734068852; c=relaxed/simple;
	bh=KjNx//tf6qnRkSn9x4PGnNW5eZ14kzaocEF//pfnNk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsI4q9QjKFbM0+TqeBlR/ycRhLy4/OpBT2fbAc9mnLB7PGetEBBeeAk7EfgArxi39ij9lDKSSQhmzYlEkKG/+LWDz9g3l0bwcudxLEaUKAcrH0bDbB4J6c7CXnUyVjxycOUoxOZxrWJVqe26vDBVcBxSZEcW5a6VTpTVFFgbHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJuqp3yV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7feb6871730so980808a12.2;
        Thu, 12 Dec 2024 21:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734068850; x=1734673650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WABVozVaGAUeC6WVv6dNDEWCXVmF+XIaxOqP2xXRnSs=;
        b=LJuqp3yVhmGWLGcD9S7APrALZnF7i2fnaEG5Yhw176+Jjy6UYXM6H/LBMMonX+7Hsp
         rA0EGNnLGTTF003unito2Yz7P422zOhQtMz6nhpKyX4fCiUQWSLzix9rzswHyPMzp+4U
         SXTB/8eZ+XU51o9FdKUbhCuibaIUnaL0wdLOLxgbj4fckQTkmND/8xuhbGZ78DZwnA0n
         qTFE4SP5W/9xvOPNLQxTX38yT5oRjbukLv5ygxKXaER5PfGCLCY3UDIc8HA97Dm9beDb
         XKssdUZ6PcU8a12AW7alaWrI2qY7hROFwmfVyVXE/SwuZa0BcxaqHDGYJewJZzJL5XH8
         ORwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734068850; x=1734673650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WABVozVaGAUeC6WVv6dNDEWCXVmF+XIaxOqP2xXRnSs=;
        b=Ch1/cL5FbOBiSEhovxkNi8JCU/DiEmEeS5jPgbVmjmxjaBUqCJEa2huquGVDoICz+K
         ZmsuNSCUXOL1Pg9hn0aBnwOgYJ/Goxkv2B6a0n2O/jzaa8eoRRjY3mXa2xzwNoUFNB19
         n/puoFh9x7d38yOtc4+KAEo9CxRzldu5o08ST5yATx1KbzOaY6u1T/XrIhiiFN8k6xOU
         kU13y+39SErx4VmInZOP4reXhgyGZHh0b4/NYuIEa1Z2bgJVjh95S8Mc0UIurMkT5nKZ
         dOKTW5joXhDWkZyIu4Qe5k1LSAPj5mrofKPbqKzQxa0KT+hVJaylK5FDdU+QFICF4cYs
         84SA==
X-Forwarded-Encrypted: i=1; AJvYcCUpHRbdn8yp48G2ER6BI6Kxi+UvHEg1xIDeAM0x0jK0QPAMjtNqiFQHVxcgjIJNUIg1tkW9GGzm9sJRzZzZ7ApyMw8f2MY=@vger.kernel.org, AJvYcCVI6hx69v53ErCLe5m3sJnkqEUxVY0WzBhb8F3YrpNU1avCC/msihvr5bqpsPOQUoHNRi8JQEj10WMKtN0rKxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7nRJH8IdXCGLugKl9HdtdeOTRFEDyjsuR1kVexZ4OCz2oku5
	88lnKTkrOUhTtXxkGjHhhWy+H/oBAlib9kdk2n06GnpCwgExyHwU
X-Gm-Gg: ASbGncv7g7UnL5Yp2jF9TVh8PrPcedfbi8LzOaJhXXETLynsZ7C9XvAL1E10+oGx2n1
	R6zIPcBJDdT45E8/WozC6QdUnHdLQY9H9rGI+nYp1Fl+p12N4ENJ3mjGwaP5nF24INolklYYzE9
	E1r8+FMp2InrcDrOjTh88NHbIGYtiJHurRh1yr/Y/yY9v/CeVMYREjwSaIeZ6kqGDsCaDrPgJy8
	3zBtnTd7sz3OoaRVutK6oBOH7xf3LoCmup2mWLcosmH1tNz1PpDP3es37DNTGXKwysT1w7jm4Kj
	4rZ+Jlc=
X-Google-Smtp-Source: AGHT+IGFE1mRmyM5NL2PUAWpAoscqFHXvU8vwTTuUZkYB6i9lL3x0jZgiaefTaKhcRetCPxuiJ6lzw==
X-Received: by 2002:a17:90b:3889:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f28fa55d20mr2136406a91.6.1734068850070;
        Thu, 12 Dec 2024 21:47:30 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216483dd292sm82564985ad.226.2024.12.12.21.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Dec 2024 21:47:29 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	x86@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	ocfs2-devel@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Ofir Bitton <obitton@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 6/7] drivers: Repace get_task_comm() with %pTN
Date: Fri, 13 Dec 2024 13:46:09 +0800
Message-Id: <20241213054610.55843-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241213054610.55843-1-laoar.shao@gmail.com>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task->comm is guaranteed to be NUL-terminated, we can print it
directly without the need to copy it into a separate buffer. This
simplifies the code and avoids unnecessary operations.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/accel/habanalabs/common/context.c         |  5 ++---
 .../accel/habanalabs/common/habanalabs_ioctl.c    | 15 +++++----------
 .../gpu/drm/i915/display/intel_display_driver.c   | 10 ++++------
 drivers/gpu/drm/nouveau/nouveau_chan.c            |  4 +---
 drivers/gpu/drm/nouveau/nouveau_drm.c             |  7 +++----
 drivers/tty/tty_io.c                              |  5 ++---
 6 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/accel/habanalabs/common/context.c b/drivers/accel/habanalabs/common/context.c
index b83141f58319..e4026051b735 100644
--- a/drivers/accel/habanalabs/common/context.c
+++ b/drivers/accel/habanalabs/common/context.c
@@ -199,7 +199,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 {
-	char task_comm[TASK_COMM_LEN];
 	int rc = 0, i;
 
 	ctx->hdev = hdev;
@@ -271,8 +270,8 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 
 		mutex_init(&ctx->ts_reg_lock);
 
-		dev_dbg(hdev->dev, "create user context, comm=\"%s\", asid=%u\n",
-			get_task_comm(task_comm, current), ctx->asid);
+		dev_dbg(hdev->dev, "create user context, comm=\"%pTN\", asid=%u\n",
+			current, ctx->asid);
 	}
 
 	return 0;
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 1dd6e23172ca..32678cd0775a 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -1279,13 +1279,10 @@ static long _hl_ioctl(struct hl_fpriv *hpriv, unsigned int cmd, unsigned long ar
 		retcode = -EFAULT;
 
 out_err:
-	if (retcode) {
-		char task_comm[TASK_COMM_LEN];
-
+	if (retcode)
 		dev_dbg_ratelimited(dev,
-				"error in ioctl: pid=%d, comm=\"%s\", cmd=%#010x, nr=%#04x\n",
-				task_pid_nr(current), get_task_comm(task_comm, current), cmd, nr);
-	}
+				"error in ioctl: pid=%d, comm=\"%pTN\", cmd=%#010x, nr=%#04x\n",
+				task_pid_nr(current), current, cmd, nr);
 
 	if (kdata != stack_kdata)
 		kfree(kdata);
@@ -1308,11 +1305,9 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
 	if (nr == _IOC_NR(DRM_IOCTL_HL_INFO)) {
 		ioctl = &hl_ioctls_control[nr - HL_COMMAND_START];
 	} else {
-		char task_comm[TASK_COMM_LEN];
-
 		dev_dbg_ratelimited(hdev->dev_ctrl,
-				"invalid ioctl: pid=%d, comm=\"%s\", cmd=%#010x, nr=%#04x\n",
-				task_pid_nr(current), get_task_comm(task_comm, current), cmd, nr);
+				"invalid ioctl: pid=%d, comm=\"%pTN\", cmd=%#010x, nr=%#04x\n",
+				task_pid_nr(current), current, cmd, nr);
 		return -ENOTTY;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 56b78cf6b854..416aff49ceb8 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -391,7 +391,6 @@ void intel_display_driver_resume_access(struct drm_i915_private *i915)
  */
 bool intel_display_driver_check_access(struct drm_i915_private *i915)
 {
-	char comm[TASK_COMM_LEN];
 	char current_task[TASK_COMM_LEN + 16];
 	char allowed_task[TASK_COMM_LEN + 16] = "none";
 
@@ -399,13 +398,12 @@ bool intel_display_driver_check_access(struct drm_i915_private *i915)
 	    i915->display.access.allowed_task == current)
 		return true;
 
-	snprintf(current_task, sizeof(current_task), "%s[%d]",
-		 get_task_comm(comm, current),
-		 task_pid_vnr(current));
+	snprintf(current_task, sizeof(current_task), "%pTN[%d]",
+		 current, task_pid_vnr(current));
 
 	if (i915->display.access.allowed_task)
-		snprintf(allowed_task, sizeof(allowed_task), "%s[%d]",
-			 get_task_comm(comm, i915->display.access.allowed_task),
+		snprintf(allowed_task, sizeof(allowed_task), "%pTN[%d]",
+			 i915->display.access.allowed_task,
 			 task_pid_vnr(i915->display.access.allowed_task));
 
 	drm_dbg_kms(&i915->drm,
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 2cb2e5675807..5bcfda6ecafe 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -279,7 +279,6 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
 	const u64 plength = 0x10000;
 	const u64 ioffset = plength;
 	const u64 ilength = 0x02000;
-	char name[TASK_COMM_LEN];
 	int cid, ret;
 	u64 size;
 
@@ -338,8 +337,7 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
 		chan->userd = &chan->user;
 	}
 
-	get_task_comm(name, current);
-	snprintf(args.name, sizeof(args.name), "%s[%d]", name, task_pid_nr(current));
+	snprintf(args.name, sizeof(args.name), "%pTN[%d]", current, task_pid_nr(current));
 
 	ret = nvif_object_ctor(&device->object, "abi16ChanUser", 0, hosts[cid].oclass,
 			       &args, sizeof(args), &chan->user);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 107f63f08bd9..3264465cded6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1159,7 +1159,7 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_cli *cli;
-	char name[32], tmpname[TASK_COMM_LEN];
+	char name[32];
 	int ret;
 
 	/* need to bring up power immediately if opening device */
@@ -1169,10 +1169,9 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 		return ret;
 	}
 
-	get_task_comm(tmpname, current);
 	rcu_read_lock();
-	snprintf(name, sizeof(name), "%s[%d]",
-		 tmpname, pid_nr(rcu_dereference(fpriv->pid)));
+	snprintf(name, sizeof(name), "%pTN[%d]",
+		 current, pid_nr(rcu_dereference(fpriv->pid)));
 	rcu_read_unlock();
 
 	if (!(cli = kzalloc(sizeof(*cli), GFP_KERNEL))) {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 9771072da177..bd39167d4234 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2622,14 +2622,13 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
 
 static int tty_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
-	char comm[TASK_COMM_LEN];
 	int flags;
 
 	flags = ss->flags & ASYNC_DEPRECATED;
 
 	if (flags)
-		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-				__func__, get_task_comm(comm, current), flags);
+		pr_warn_ratelimited("%s: '%pTN' is using deprecated serial flags (with no effect): %.8x\n",
+				__func__, current, flags);
 
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
-- 
2.43.5


