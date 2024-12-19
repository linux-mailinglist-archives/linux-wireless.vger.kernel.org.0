Return-Path: <linux-wireless+bounces-16573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3519F72B8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 03:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B56816070B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399E91990AB;
	Thu, 19 Dec 2024 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPp9cMLX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926F86345;
	Thu, 19 Dec 2024 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575729; cv=none; b=nQtXLlQeRiDJzP4L6UVhBVsIKTxbje9HV8vn9aQMJfcs3WQxoi1lhkEtVTqDhnO+SW2x6xipPUJCmMEFRi+OOlGhVrVtvhWE1KlBSzUV9a43XUeun7VESFA44Bo8w2T7Q3T5Mb/zaixTsEqJy/GieL6o1yHHq8wcOz4X1gcIeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575729; c=relaxed/simple;
	bh=VeLbyOfvsBoD/0QCt6XTwvSQyL69DBSOWRzzq8d05w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHYo6jf3mgSPhu3vbSSUz+0V+a2eRGHC1xNUBKWTrcKx9jCd0Dg6hgJFPW5nfv3atbfNp2SvL3dhhAz8AIH2UNx7NHkOjbPlmPMia+zW1xF5l6NayP2FrKa2UVdNXhXlygEORnaq459Ke6q6J+W/QDjE8w9dm0nSe4hBCAiHKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPp9cMLX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7273967f2f0so380879b3a.1;
        Wed, 18 Dec 2024 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734575727; x=1735180527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lFqN6P61Vcxg60EP2migAvtPpkWX8ZEoCx5nNg3/cM=;
        b=XPp9cMLXnifLLA4GGsg2+q5Q833Ki5DDLHERUPCx6TM0WtQstBGyfYD5Su2QyA6hMX
         ropCIa7P4Gq4kOh7+UfI+PA/T5mCDx1pQodG5FG0A9wNhjiSRC9632dOwolJq/F7hPZY
         if/+tdS87qY2Ea2ZDp2deXHG7MOZA17vYHmnQGoXpY+v7Yy2cLypd7zk4WAnzizD+7Bv
         D9Qj3usvHB0sFf8NdtF2Id2beJL4GIpPYqNhkiP1Xp74Di+jhpLYJkeys+9RYuEUkkdi
         CPG75xw/fz1KI2+i2DBIpvC/ZR1w2TuUt//anTQ5ajwVsvIhJZgwLlbnaK07G6p/ZvMs
         2mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575727; x=1735180527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lFqN6P61Vcxg60EP2migAvtPpkWX8ZEoCx5nNg3/cM=;
        b=s8rEQwBLJAlWGKqap6qxpJHZ2fcuRYt2TvvFmZhL3Hs2mzaD02LIP41X24TwczI7wj
         BInVAiedg/JpVkKsWzMjM36rsHkng5fXPRtANA4TDeNs3s/fgG8hIOAvxsopyUiZqTnE
         s6dXNrczS1KFozpXUvSzyh3KDFECkScQnXQX7fgzlcyapVZ5IDuLFkTc/QAQYPYbIIyt
         tYz/+q5i/C1moXpNsgFgjkmsDenOYsg0PPKYTK9Vtp8iEEa5iD7nny2JAo5dh8MHBPqE
         HFcthJxCtJ2gMXJ479YA6tGlQ9gkprACAq4tUoHepngLNYKo+IhbTH7P+isWySU69YYk
         OF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8jO9YPQrNnyH5a4maBWRH4nOhtSe1qKQ1x+uYFoIyVdda5PEa3yIAslltSVvKJjRvSVb4Rsz3zO4ZuGA=@vger.kernel.org, AJvYcCVmb99WscVrPyYIcTJ3eeYxbAwG/UfjjccJdkRe1RGA+KtJMOS7WNAs6AnlTC2L9Gx7bHC9xL5MWUQvj1/ZU/hdUuj1FtPs@vger.kernel.org, AJvYcCWPQKLfWajNaChZ50967PKgFUtLj19OWae/SW5/tbaeM7VPV45JRd3hvnPCv5G4hvjQ/qLoMBvFtOMEEkUNpwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMUqUiXcsjwLcF8Gm4JehPlB8CZCfB7bSMsVguvwt/rYUF22u
	W+MF5Bdr5IWIQOMIsKb3JMXWrmXv7cDRHyPSDVxA2jpgdgtAiRC8vzd5EOgBl9c=
X-Gm-Gg: ASbGncs/bNb2WKKkCj5c/4GIz7zig2sq50h0IZQ0QnjlqU3//4IQyH6lOLodqHEGMxe
	Q1+5VtBY+PYYQlZJ1b+/R06vpWbaIHBaOGPfw0vy8EPDYIUKjjbQJUmOHUZXb+ekZuWpuEifsIZ
	8RAr9uDfGFSL8OMZ/blxE+mhRwbdgxLCBqOI/cZbSjGbAqbSgU2qdGZuYRfS196AcB0JI5wiX4v
	zHmXmNxFXbmb6SoqM+RHm6dZzILMAxTvgRWpn6YCCHXYFIeHh20vAlDtbM694I0c9EwjtLufzdO
	cU+Fmdg=
X-Google-Smtp-Source: AGHT+IEASYTltYbmKh5ZDA03zBv0Z8CD36/wkPvI28CV3U8CPosE7HG5sfVxRVIBm8iQbfYV7EQNzQ==
X-Received: by 2002:a05:6a21:788c:b0:1e1:b727:181a with SMTP id adf61e73a8af0-1e5c763cc43mr2386992637.24.1734575726666;
        Wed, 18 Dec 2024 18:35:26 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm142163a12.40.2024.12.18.18.35.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Dec 2024 18:35:26 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	pmladek@suse.com,
	kvalo@kernel.org,
	bp@alien8.de,
	andriy.shevchenko@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
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
	Jiri Slaby <jirislaby@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/5] drivers: Remove get_task_comm() and print task comm directly
Date: Thu, 19 Dec 2024 10:34:52 +0800
Message-Id: <20241219023452.69907-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20241219023452.69907-1-laoar.shao@gmail.com>
References: <20241219023452.69907-1-laoar.shao@gmail.com>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org> (For tty)
Reviewed-by: Lyude Paul <lyude@redhat.com> (For nouveau)
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
 drivers/accel/habanalabs/common/context.c           |  3 +--
 drivers/accel/habanalabs/common/habanalabs_ioctl.c  | 11 +++--------
 drivers/gpu/drm/i915/display/intel_display_driver.c |  6 ++----
 drivers/gpu/drm/nouveau/nouveau_chan.c              |  4 +---
 drivers/gpu/drm/nouveau/nouveau_drm.c               |  5 ++---
 drivers/tty/tty_io.c                                |  3 +--
 6 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/accel/habanalabs/common/context.c b/drivers/accel/habanalabs/common/context.c
index b83141f58319..9f212b17611a 100644
--- a/drivers/accel/habanalabs/common/context.c
+++ b/drivers/accel/habanalabs/common/context.c
@@ -199,7 +199,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 {
-	char task_comm[TASK_COMM_LEN];
 	int rc = 0, i;
 
 	ctx->hdev = hdev;
@@ -272,7 +271,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 		mutex_init(&ctx->ts_reg_lock);
 
 		dev_dbg(hdev->dev, "create user context, comm=\"%s\", asid=%u\n",
-			get_task_comm(task_comm, current), ctx->asid);
+			current->comm, ctx->asid);
 	}
 
 	return 0;
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 1dd6e23172ca..8729a0c57d78 100644
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
 				"error in ioctl: pid=%d, comm=\"%s\", cmd=%#010x, nr=%#04x\n",
-				task_pid_nr(current), get_task_comm(task_comm, current), cmd, nr);
-	}
+				task_pid_nr(current), current->comm, cmd, nr);
 
 	if (kdata != stack_kdata)
 		kfree(kdata);
@@ -1308,11 +1305,9 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
 	if (nr == _IOC_NR(DRM_IOCTL_HL_INFO)) {
 		ioctl = &hl_ioctls_control[nr - HL_COMMAND_START];
 	} else {
-		char task_comm[TASK_COMM_LEN];
-
 		dev_dbg_ratelimited(hdev->dev_ctrl,
 				"invalid ioctl: pid=%d, comm=\"%s\", cmd=%#010x, nr=%#04x\n",
-				task_pid_nr(current), get_task_comm(task_comm, current), cmd, nr);
+				task_pid_nr(current), current->comm, cmd, nr);
 		return -ENOTTY;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 56b78cf6b854..62596424a9aa 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -391,7 +391,6 @@ void intel_display_driver_resume_access(struct drm_i915_private *i915)
  */
 bool intel_display_driver_check_access(struct drm_i915_private *i915)
 {
-	char comm[TASK_COMM_LEN];
 	char current_task[TASK_COMM_LEN + 16];
 	char allowed_task[TASK_COMM_LEN + 16] = "none";
 
@@ -400,12 +399,11 @@ bool intel_display_driver_check_access(struct drm_i915_private *i915)
 		return true;
 
 	snprintf(current_task, sizeof(current_task), "%s[%d]",
-		 get_task_comm(comm, current),
-		 task_pid_vnr(current));
+		 current->comm, task_pid_vnr(current));
 
 	if (i915->display.access.allowed_task)
 		snprintf(allowed_task, sizeof(allowed_task), "%s[%d]",
-			 get_task_comm(comm, i915->display.access.allowed_task),
+			 i915->display.access.allowed_task->comm,
 			 task_pid_vnr(i915->display.access.allowed_task));
 
 	drm_dbg_kms(&i915->drm,
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 2cb2e5675807..cd659b9fd1d9 100644
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
+	snprintf(args.name, sizeof(args.name), "%s[%d]", current->comm, task_pid_nr(current));
 
 	ret = nvif_object_ctor(&device->object, "abi16ChanUser", 0, hosts[cid].oclass,
 			       &args, sizeof(args), &chan->user);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 107f63f08bd9..ea7206484d22 100644
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
 	snprintf(name, sizeof(name), "%s[%d]",
-		 tmpname, pid_nr(rcu_dereference(fpriv->pid)));
+		 current->comm, pid_nr(rcu_dereference(fpriv->pid)));
 	rcu_read_unlock();
 
 	if (!(cli = kzalloc(sizeof(*cli), GFP_KERNEL))) {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 9771072da177..102e31f62f76 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2622,14 +2622,13 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
 
 static int tty_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
-	char comm[TASK_COMM_LEN];
 	int flags;
 
 	flags = ss->flags & ASYNC_DEPRECATED;
 
 	if (flags)
 		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-				__func__, get_task_comm(comm, current), flags);
+				__func__, current->comm, flags);
 
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
-- 
2.43.5


