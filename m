Return-Path: <linux-wireless+bounces-3710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2B85874E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4EC28B4E5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB26155A59;
	Fri, 16 Feb 2024 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pjlvdI/s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB715444A
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115624; cv=none; b=tj9fYiyynpsoyQGR35wg3wqf/rdUtF0hrka4Q5JIdA0tYrKoiIpFQkkA0NDEEW+/GpCSaoQVH4gdgXkGvp0vVKvLp9/tg0FiqTzvZwa5xQDwKxryV3pKZsiDJNffaUYBI9wni3i5lFb+O/7ibskrZbMrzl+6HF/hG2Hb4tVzOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115624; c=relaxed/simple;
	bh=X4ZHvrwqZEyBeAi01/H9KK4yq2KrD2I61w6lZdlucm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIyAcnKwMCvLDlRH4KV8XlXb40oUmPAcdxlfpfjHBy2cj21acqkDx38YQdCSyD8Qnc1IdusIvuq5MFdpWZ0+1LSf4RXP9VZJIeoAjWq4E/BUn+DGzs4YMFwoUq4Su7A7PCvvj44d8KWP+gw/RVb0YnxMSSLsIEIRMlTAo61qea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pjlvdI/s; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso8129365e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115615; x=1708720415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuKEVUfMPtlst7kCN+rX1Jrkz0IJ3Rvo08UBdK/Kj2o=;
        b=pjlvdI/sxQ1gFz5TMLL66V0LLiJgQvBTtyXuouQZHff9UHlgn2uORC/wYhKzNlDM3i
         EnhSwxY8acZllak0pUw3nLOZV9CkKRXP1ElKd2nOJH9kA8zZnFgSxP541NCkg9bE1IBf
         GjGgKMqjuskv/m5Fm3uEhSY3rD1U59W6DdljXEIKHksHayJFZ0Vm3nQg5Nw2IhSccgj1
         9w+Fv2WqDWlDdtJ1vQE8PUR+BEO/f9+1duO+Ffl2LbX30ZPNNT87kfAAI2H9brncOnuO
         Rqxbc6VF2dNY3KHI56iQgD58kFjVeTVkLW3oxF0M3o8yclyHVXk2Mg5XFSgrECFv+odr
         iU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115615; x=1708720415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuKEVUfMPtlst7kCN+rX1Jrkz0IJ3Rvo08UBdK/Kj2o=;
        b=IutEGHuo5AS5MBvbHdTfSFG4ZCDwBbErW1PjMMkOw5SIq/aOBhdkPLjh0hUd2xLMYj
         0dbmk77ypF2/FnVvRf5vOPrsXNYVsFryPm1RlVNKsgQK/N2h4iHDjuQnj0sfbvj+BAm3
         rG+F4Uvf8pgQb8RoZAtu3E5YjpSBQJ/QyAdNZArr041epSbP2GrIErclmVdp6v4zk7Tu
         yJcEG/ZFlHXu278yS73SmDThGsIPa+z069xp1YjzkCdj1p8h8++LGBuSjPoY3g4Vid3F
         B+Lr+G9/fgvUtBHKBK+A2VQY6sUkhJvk+JTSIH3QPjKEP6753f/Q/qGD+sNP+cctm+kQ
         1kAw==
X-Forwarded-Encrypted: i=1; AJvYcCXEj5D/v4qw5Oz1ltmkleVffy3L6u3xut9b78ONZf00jB5IrtlHjsDOzd15maW70YbqW+FwDmiWw5J0ax77xWk5ZDvdG39kkc1L4Croh40=
X-Gm-Message-State: AOJu0YzJzYvclq8Wrh5zWAV5XikUcMHoWQzownUmaUo3L4tOR8WvOhPm
	zbjYzsocFguI9NAZ1TPwyELtKFaExQ6dabkLJDk7Tl2Lk+w8SRkNWkfWGKwUFBoX2u+wRqEAyZf
	6
X-Google-Smtp-Source: AGHT+IHb8SpXqlCOaYZS0/LtKlaiDT1Th7jjQPV0KlR4ZbBnZeojtxBKYA7yzzVwfWdcIv+Ln3zIjQ==
X-Received: by 2002:a05:600c:3d9a:b0:411:e009:f3c7 with SMTP id bi26-20020a05600c3d9a00b00411e009f3c7mr4161252wmb.4.1708115615191;
        Fri, 16 Feb 2024 12:33:35 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:34 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 15/18] power: sequencing: implement the pwrseq core
Date: Fri, 16 Feb 2024 21:32:12 +0100
Message-Id: <20240216203215.40870-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the power sequencing subsystem allowing devices to share
complex powering-up and down procedures. It's split into the consumer
and provider parts but does not implement any new DT bindings so that
the actual power sequencing is never revealed in the DT representation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS                       |    8 +
 drivers/power/Kconfig             |    1 +
 drivers/power/Makefile            |    1 +
 drivers/power/sequencing/Kconfig  |   12 +
 drivers/power/sequencing/Makefile |    4 +
 drivers/power/sequencing/core.c   | 1065 +++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h   |   56 ++
 include/linux/pwrseq/provider.h   |   75 ++
 8 files changed, 1222 insertions(+)
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7980e5b1ad..5187a30952e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17647,6 +17647,14 @@ F:	include/linux/pm_*
 F:	include/linux/powercap.h
 F:	kernel/configs/nopm.config
 
+POWER SEQUENCING
+M:	Bartosz Golaszewski <brgl@bgdev.pl>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
+F:	drivers/power/sequencing/
+F:	include/linux/pwrseq/
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 696bf77a7042..9a8e44ca9ae4 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 source "drivers/power/reset/Kconfig"
+source "drivers/power/sequencing/Kconfig"
 source "drivers/power/supply/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index effbf0377f32..962a2cd30a51 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_POWER_RESET)	+= reset/
+obj-$(CONFIG_POWER_SEQUENCING)	+= sequencing/
 obj-$(CONFIG_POWER_SUPPLY)	+= supply/
diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
new file mode 100644
index 000000000000..ba5732b1dbf8
--- /dev/null
+++ b/drivers/power/sequencing/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menuconfig POWER_SEQUENCING
+	tristate "Power Sequencing support"
+	help
+	  Say Y here to enable the Power Sequencing subsystem.
+
+	  This subsystem is designed to control power to devices that share
+	  complex resources and/or require specific power sequences to be run
+	  during power-up.
+
+	  If unsure, say no.
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
new file mode 100644
index 000000000000..dcdf8c0c159e
--- /dev/null
+++ b/drivers/power/sequencing/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
+pwrseq-core-y				:= core.o
diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
new file mode 100644
index 000000000000..00ad7964a0b6
--- /dev/null
+++ b/drivers/power/sequencing/core.c
@@ -0,0 +1,1065 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/radix-tree.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+
+/*
+ * Power-sequencing framework for linux.
+ *
+ * This subsystem allows power sequence providers to register a set of targets
+ * that consumers may request and power-up/down.
+ *
+ * Glossary:
+ *
+ * Unit - a unit is a discreet chunk of a power sequence. For instance one unit
+ * may enable a set of regulators, another may enable a specific GPIO. Units
+ * can define dependencies in the form of other units that must be enabled
+ * before it itself can be.
+ *
+ * Target - a target is a set of units (composed of the "final" unit and its
+ * dependencies) that a consumer selects by its name when requesting a handle
+ * to the power sequencer. Via the dependency system, multiple targets may
+ * share the same parts of a power sequence but ignore parts that are
+ * irrelevant.
+ *
+ * Descriptor - a handle passed by the pwrseq core to every consumer that
+ * serves as the entry point to the provider layer. It ensures coherence
+ * between different users and keeps reference counting consistent.
+ *
+ * Each provider must define a .match() callback whose role is to determine
+ * whether a potential consumer is in fact associated with this sequencer.
+ * This allows creating abstraction layers on top of regular device-tree
+ * resources like regulators, clocks and other nodes connected to the consumer
+ * via phandle.
+ */
+
+static DEFINE_IDA(pwrseq_ida);
+
+/*
+ * Protects the device list on the pwrseq bus from concurrent modifications
+ * but allows simultaneous read-only access.
+ */
+static DECLARE_RWSEM(pwrseq_sem);
+
+/**
+ * struct pwrseq_unit - Private power-sequence unit data.
+ * @ref: Reference count for this object. When it goes to 0, the object is
+ *       destroyed.
+ * @name: Name of this target.
+ * @list: Link to siblings on the list of all units of a single sequencer.
+ * @deps: List of units on which this unit depends.
+ * @enable: Callback running the part of the power-on sequence provided by
+ *          this unit.
+ * @disable: Callback running the part of the power-off sequence provided
+ *           by this unit.
+ * @enable_count: Current number of users that enabled this unit. May be the
+ *                consumer of the power sequencer or other units that depend
+ *                on this one.
+ */
+struct pwrseq_unit {
+	struct kref ref;
+	const char *name;
+	struct list_head list;
+	struct list_head deps;
+	pwrseq_power_state_func enable;
+	pwrseq_power_state_func disable;
+	unsigned int enable_count;
+};
+
+static struct pwrseq_unit *pwrseq_unit_new(const struct pwrseq_unit_data *data)
+{
+	struct pwrseq_unit *unit;
+
+	unit = kzalloc(sizeof(*unit), GFP_KERNEL);
+	if (!unit)
+		return NULL;
+
+	unit->name = kstrdup_const(data->name, GFP_KERNEL);
+	if (!unit->name) {
+		kfree(unit);
+		return NULL;
+	}
+
+	kref_init(&unit->ref);
+	INIT_LIST_HEAD(&unit->deps);
+	unit->enable = data->enable;
+	unit->disable = data->disable;
+
+	return unit;
+}
+
+static struct pwrseq_unit *pwrseq_unit_incref(struct pwrseq_unit *unit)
+{
+	kref_get(&unit->ref);
+
+	return unit;
+}
+
+static void pwrseq_unit_release(struct kref *ref);
+
+static void pwrseq_unit_decref(struct pwrseq_unit *unit)
+{
+	kref_put(&unit->ref, pwrseq_unit_release);
+}
+
+/**
+ * struct pwrseq_unit_dep - Wrapper around a reference to the unit structure
+ *                          allowing to keep it on multiple dependency lists
+ *                          in different units.
+ * @list: Siblings on the list.
+ * @unit: Address of the referenced unit.
+ */
+struct pwrseq_unit_dep {
+	struct list_head list;
+	struct pwrseq_unit *unit;
+};
+
+static struct pwrseq_unit_dep *pwrseq_unit_dep_new(struct pwrseq_unit *unit)
+{
+	struct pwrseq_unit_dep *dep;
+
+	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+	if (!dep)
+		return NULL;
+
+	dep->unit = unit;
+
+	return dep;
+}
+
+static void pwrseq_unit_dep_free(struct pwrseq_unit_dep *ref)
+{
+	pwrseq_unit_decref(ref->unit);
+	kfree(ref);
+}
+
+static void pwrseq_unit_free_deps(struct list_head *list)
+{
+	struct pwrseq_unit_dep *dep, *next;
+
+	list_for_each_entry_safe(dep, next, list, list) {
+		list_del(&dep->list);
+		pwrseq_unit_dep_free(dep);
+	}
+}
+
+static void pwrseq_unit_release(struct kref *ref)
+{
+	struct pwrseq_unit *unit = container_of(ref, struct pwrseq_unit, ref);
+
+	pwrseq_unit_free_deps(&unit->deps);
+	list_del(&unit->list);
+	kfree_const(unit->name);
+	kfree(unit);
+}
+
+/**
+ * struct pwrseq_target - Private power-sequence target data.
+ * @list: Siblings on the list of all targets exposed by a power sequencer.
+ * @name: Name of the target.
+ * @unit: Final unit for this target.
+ * @post_enable: Callback run after the target unit has been enabled, *after*
+ *               the state lock has been released. It's useful for implementing
+ *               boot-up delays without blocking other users from powering up
+ *               using the same power sequencer.
+ */
+struct pwrseq_target {
+	struct list_head list;
+	const char *name;
+	struct pwrseq_unit *unit;
+	pwrseq_power_state_func post_enable;
+};
+
+static struct pwrseq_target *
+pwrseq_target_new(const struct pwrseq_target_data *data)
+{
+	struct pwrseq_target *target;
+
+	target = kzalloc(sizeof(*target), GFP_KERNEL);
+	if (!target)
+		return NULL;
+
+	target->name = kstrdup_const(data->name, GFP_KERNEL);
+	if (!target->name) {
+		kfree(target);
+		return NULL;
+	}
+
+	target->post_enable = data->post_enable;
+
+	return target;
+}
+
+static void pwrseq_target_free(struct pwrseq_target *target)
+{
+	pwrseq_unit_decref(target->unit);
+	kfree_const(target->name);
+	kfree(target);
+}
+
+/**
+ * struct pwrseq_device - Private power sequencing data.
+ * @dev: Device struct associated with this sequencer.
+ * @id: Device ID.
+ * @owner: Prevents removal of active power sequencing providers.
+ * @rw_lock: Protects the device from being unregistered while in use.
+ * @state_lock: Prevents multiple users running the power sequence at the same
+ *              time.
+ * @match: Power sequencer matching callback.
+ * @targets: List of targets exposed by this sequencer.
+ * @units: List of all units supported by this sequencer.
+ */
+struct pwrseq_device {
+	struct device dev;
+	int id;
+	struct module *owner;
+	struct rw_semaphore rw_lock;
+	struct mutex state_lock;
+	pwrseq_match_func match;
+	struct list_head targets;
+	struct list_head units;
+};
+
+static struct pwrseq_device *to_pwrseq_device(struct device *dev)
+{
+	return container_of(dev, struct pwrseq_device, dev);
+}
+
+static struct pwrseq_device *pwrseq_device_get(struct pwrseq_device *pwrseq)
+{
+	get_device(&pwrseq->dev);
+
+	return pwrseq;
+}
+
+static void pwrseq_device_put(struct pwrseq_device *pwrseq)
+{
+	put_device(&pwrseq->dev);
+}
+
+/**
+ * struct pwrseq_desc - Wraps access to the pwrseq_device and ensures that one
+ *                      user cannot break the reference counting for others.
+ * @pwrseq: Reference to the power sequencing device.
+ * @target: Reference to the target this descriptor allows to control.
+ * @powered_on: Power state set by the holder of the descriptor (not necessarily
+ * corresponding to the actual power state of the device).
+ */
+struct pwrseq_desc {
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_target *target;
+	bool powered_on;
+};
+
+static const struct bus_type pwrseq_bus = {
+	.name = "pwrseq",
+};
+
+static void pwrseq_release(struct device *dev)
+{
+	struct pwrseq_device *pwrseq = to_pwrseq_device(dev);
+	struct pwrseq_target *target;
+
+	list_for_each_entry(target, &pwrseq->targets, list)
+		pwrseq_target_free(target);
+
+	mutex_destroy(&pwrseq->state_lock);
+	ida_free(&pwrseq_ida, pwrseq->id);
+	kfree(pwrseq);
+}
+
+static const struct device_type pwrseq_device_type = {
+	.name = "power_sequencer",
+	.release = pwrseq_release,
+};
+
+static int pwrseq_unit_setup_deps(const struct pwrseq_unit_data **data,
+				  struct list_head *dep_list,
+				  struct list_head *unit_list,
+				  struct radix_tree_root *processed_units)
+{
+	const struct pwrseq_unit_data *pos;
+	struct pwrseq_unit_dep *dep;
+	struct pwrseq_unit *unit;
+	int ret, i;
+
+	for (i = 0; data[i]; i++) {
+		pos = data[i];
+
+		unit = radix_tree_lookup(processed_units, (unsigned long)data);
+		if (unit) {
+			pwrseq_unit_incref(unit);
+		} else {
+			unit = pwrseq_unit_new(pos);
+			if (!unit)
+				return -ENOMEM;
+
+			if (pos->deps) {
+				ret = pwrseq_unit_setup_deps(pos->deps,
+							     &unit->deps,
+							     unit_list,
+							     processed_units);
+				if (ret) {
+					pwrseq_unit_decref(unit);
+					return ret;
+				}
+			}
+
+			ret = radix_tree_insert(processed_units,
+						(unsigned long)data, unit);
+			if (ret) {
+				pwrseq_unit_decref(unit);
+				return ret;
+			}
+
+			list_add_tail(&unit->list, unit_list);
+		}
+
+		dep = pwrseq_unit_dep_new(unit);
+		if (!dep) {
+			pwrseq_unit_decref(unit);
+			return -ENOMEM;
+		}
+
+		list_add_tail(&dep->list, dep_list);
+	}
+
+	return 0;
+}
+
+static int pwrseq_target_setup_unit(struct pwrseq_target *target,
+				    const struct pwrseq_unit_data *data,
+				    struct list_head *unit_list,
+				    struct radix_tree_root *processed_units)
+{
+	struct pwrseq_unit *unit;
+	int ret;
+
+	unit = radix_tree_lookup(processed_units, (unsigned long)data);
+	if (unit) {
+		target->unit = pwrseq_unit_incref(unit);
+		return 0;
+	}
+
+	unit = pwrseq_unit_new(data);
+	if (!unit)
+		return -ENOMEM;
+
+	ret = pwrseq_unit_setup_deps(data->deps, &unit->deps, unit_list,
+				     processed_units);
+	if (ret) {
+		pwrseq_unit_decref(unit);
+		return ret;
+	}
+
+	ret = radix_tree_insert(processed_units, (unsigned long)data, unit);
+	if (ret) {
+		pwrseq_unit_decref(unit);
+		return ret;
+	}
+
+	target->unit = unit;
+	list_add_tail(&unit->list, unit_list);
+
+	return 0;
+}
+
+static int pwrseq_do_setup_targets(const struct pwrseq_target_data **data,
+				   struct pwrseq_device *pwrseq,
+				   struct radix_tree_root *processed_units)
+{
+	const struct pwrseq_target_data *pos;
+	struct pwrseq_target *target;
+	int ret, i;
+
+	for (i = 0; data[i]; i++) {
+		pos = data[i];
+
+		target = pwrseq_target_new(pos);
+		if (!target)
+			return -ENOMEM;
+
+		ret = pwrseq_target_setup_unit(target, pos->unit,
+					       &pwrseq->units,
+					       processed_units);
+		if (ret) {
+			pwrseq_target_free(target);
+			return ret;
+		}
+
+		list_add_tail(&target->list, &pwrseq->targets);
+	}
+
+	return 0;
+}
+
+static int pwrseq_setup_targets(const struct pwrseq_target_data **targets,
+				struct pwrseq_device *pwrseq)
+{
+	struct radix_tree_root processed_units;
+	struct radix_tree_iter iter;
+	void __rcu **slot;
+	int ret;
+
+	INIT_RADIX_TREE(&processed_units, GFP_KERNEL);
+	ret = pwrseq_do_setup_targets(targets, pwrseq, &processed_units);
+	radix_tree_for_each_slot(slot, &processed_units, &iter, 0)
+		radix_tree_delete(&processed_units, iter.index);
+
+	return ret;
+}
+
+/**
+ * pwrseq_device_register() - Register a new power sequencer.
+ * @config: Configuration of the new power sequencing device.
+ *
+ * The config structure is only used during the call and can be freed after
+ * the function returns. The config structure *must* have the parent device
+ * as well as the match() callback and at least one target set.
+ *
+ * Returns:
+ * Returns the address of the new pwrseq device or ERR_PTR() on failure.
+ */
+struct pwrseq_device *
+pwrseq_device_register(const struct pwrseq_config *config)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	if (!config->parent || !config->match || !config->targets ||
+	    !config->targets[0])
+		return ERR_PTR(-EINVAL);
+
+	pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
+	if (!pwrseq)
+		return ERR_PTR(-ENOMEM);
+
+	pwrseq->dev.type = &pwrseq_device_type;
+	pwrseq->dev.bus = &pwrseq_bus;
+	pwrseq->dev.parent = config->parent;
+	device_set_node(&pwrseq->dev, dev_fwnode(config->parent));
+	dev_set_drvdata(&pwrseq->dev, config->drvdata);
+
+	pwrseq->id = ida_alloc(&pwrseq_ida, GFP_KERNEL);
+	if (pwrseq->id < 0) {
+		kfree(pwrseq);
+		return ERR_PTR(pwrseq->id);
+	}
+
+	/*
+	 * From this point onwards the device's release() callback is
+	 * responsible for freeing resources.
+	 */
+	device_initialize(&pwrseq->dev);
+
+	ret = dev_set_name(&pwrseq->dev, "pwrseq.%d", pwrseq->id);
+	if (ret)
+		goto err_put_pwrseq;
+
+	pwrseq->owner = config->owner ?: THIS_MODULE;
+	pwrseq->match = config->match;
+
+	init_rwsem(&pwrseq->rw_lock);
+	mutex_init(&pwrseq->state_lock);
+	INIT_LIST_HEAD(&pwrseq->targets);
+	INIT_LIST_HEAD(&pwrseq->units);
+
+	ret = pwrseq_setup_targets(config->targets, pwrseq);
+	if (ret)
+		goto err_put_pwrseq;
+
+	scoped_guard(rwsem_write, &pwrseq_sem) {
+		ret = device_add(&pwrseq->dev);
+		if (ret)
+			goto err_put_pwrseq;
+	}
+
+	return pwrseq;
+
+err_put_pwrseq:
+	pwrseq_device_put(pwrseq);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pwrseq_device_register);
+
+/**
+ * pwrseq_device_unregister() - Unregister the power sequencer.
+ * @pwrseq: Power sequencer to unregister.
+ */
+void pwrseq_device_unregister(struct pwrseq_device *pwrseq)
+{
+	struct device *dev = &pwrseq->dev;
+	struct pwrseq_target *target;
+
+	scoped_guard(mutex, &pwrseq->state_lock) {
+		guard(rwsem_write)(&pwrseq->rw_lock);
+
+		list_for_each_entry(target, &pwrseq->targets, list)
+			WARN_ONCE(target->unit->enable_count,
+				  "REMOVING POWER SEQUENCER WITH ACTIVE USERS\n");
+
+		guard(rwsem_write)(&pwrseq_sem);
+
+		device_del(dev);
+	}
+
+	pwrseq_device_put(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_device_unregister);
+
+static void devm_pwrseq_device_unregister(void *data)
+{
+	struct pwrseq_device *pwrseq = data;
+
+	pwrseq_device_unregister(pwrseq);
+}
+
+/**
+ * devm_pwrseq_device_register() - Managed variant of pwrseq_device_register().
+ * @dev: Managing device.
+ * @config: Configuration of the new power sequencing device.
+ *
+ * Returns:
+ * Returns the address of the new pwrseq device or ERR_PTR() on failure.
+ */
+struct pwrseq_device *
+devm_pwrseq_device_register(struct device *dev,
+			    const struct pwrseq_config *config)
+{
+	struct pwrseq_device *pwrseq;
+	int ret;
+
+	pwrseq = pwrseq_device_register(config);
+	if (IS_ERR(pwrseq))
+		return pwrseq;
+
+	ret = devm_add_action_or_reset(dev, devm_pwrseq_device_unregister,
+				       pwrseq);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pwrseq;
+}
+EXPORT_SYMBOL_GPL(devm_pwrseq_device_register);
+
+/**
+ * pwrseq_device_get_data() - Get the driver private data associated with this
+ *                            sequencer.
+ * @pwrseq: Power sequencer object.
+ *
+ * Returns:
+ * Address of the private driver data.
+ */
+void *pwrseq_device_get_drvdata(struct pwrseq_device *pwrseq)
+{
+	return dev_get_drvdata(&pwrseq->dev);
+}
+EXPORT_SYMBOL_GPL(pwrseq_device_get_drvdata);
+
+struct pwrseq_match_data {
+	struct pwrseq_desc *desc;
+	struct device *dev;
+	const char *target;
+};
+
+static int pwrseq_match_device(struct device *pwrseq_dev, void *data)
+{
+	struct pwrseq_device *pwrseq = to_pwrseq_device(pwrseq_dev);
+	struct pwrseq_match_data *match_data = data;
+	struct pwrseq_target *target;
+	int ret;
+
+	guard(rwsem_read)(&pwrseq->rw_lock);
+	if (!device_is_registered(&pwrseq->dev))
+		return 0;
+
+	ret = pwrseq->match(pwrseq, match_data->dev);
+	if (ret <= 0)
+		return ret;
+
+	/* We got the matching device, let's find the right target. */
+	list_for_each_entry(target, &pwrseq->targets, list) {
+		if (strcmp(target->name, match_data->target))
+			continue;
+
+		match_data->desc->target = target;
+	}
+
+	/*
+	 * This device does not have this target. No point in deferring as it
+	 * will not get a new target dynamically later.
+	 */
+	if (!match_data->desc->target)
+		return -ENOENT;
+
+	if (!try_module_get(pwrseq->owner))
+		return -EPROBE_DEFER;
+
+	match_data->desc->pwrseq = pwrseq_device_get(pwrseq);
+
+	return 1;
+}
+
+/**
+ * pwrseq_get() - Get the power sequencer associated with this device.
+ * @dev: Device for which to get the sequencer.
+ * @target: Name of the target exposed by the sequencer this device wants to
+ *          reach.
+ *
+ * Returns:
+ * New power sequencer descriptor for use by the consumer driver or ERR_PTR()
+ * on failure.
+ */
+struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
+{
+	struct pwrseq_match_data match_data;
+	int ret;
+
+	struct pwrseq_desc *desc __free(kfree) = kzalloc(sizeof(*desc),
+							 GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	match_data.desc = desc;
+	match_data.dev = dev;
+	match_data.target = target;
+
+	guard(rwsem_read)(&pwrseq_sem);
+
+	ret = bus_for_each_dev(&pwrseq_bus, NULL, &match_data,
+			       pwrseq_match_device);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (ret == 0)
+		/* No device matched. */
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return no_free_ptr(desc);
+}
+EXPORT_SYMBOL_GPL(pwrseq_get);
+
+/**
+ * pwrseq_put() - Release the power sequencer descriptor.
+ * @desc: Descriptor to release.
+ */
+void pwrseq_put(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+
+	if (!desc)
+		return;
+
+	pwrseq = desc->pwrseq;
+
+	if (desc->powered_on)
+		pwrseq_power_off(desc);
+
+	kfree(desc);
+	module_put(pwrseq->owner);
+	pwrseq_device_put(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_put);
+
+static void devm_pwrseq_put(void *data)
+{
+	struct pwrseq_desc *desc = data;
+
+	pwrseq_put(desc);
+}
+
+/**
+ * devm_pwrseq_get() - Managed variant of pwrseq_get().
+ * @dev: Device for which to get the sequencer and which also manages its
+ *       lifetime.
+ * @target: Name of the target exposed by the sequencer this device wants to
+ *          reach.
+ *
+ * Returns:
+ * New power sequencer descriptor for use by the consumer driver or ERR_PTR()
+ * on failure.
+ */
+struct pwrseq_desc *devm_pwrseq_get(struct device *dev, const char *target)
+{
+	struct pwrseq_desc *desc;
+	int ret;
+
+	desc = pwrseq_get(dev, target);
+	if (IS_ERR(desc))
+		return desc;
+
+	ret = devm_add_action_or_reset(dev, devm_pwrseq_put, desc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(devm_pwrseq_get);
+
+static int pwrseq_unit_enable(struct pwrseq_device *pwrseq,
+			      struct pwrseq_unit *target);
+static int pwrseq_unit_disable(struct pwrseq_device *pwrseq,
+			       struct pwrseq_unit *target);
+
+static int pwrseq_unit_enable_deps(struct pwrseq_device *pwrseq,
+				   struct list_head *list)
+{
+	struct pwrseq_unit_dep *pos;
+	int ret = 0;
+
+	list_for_each_entry(pos, list, list) {
+		ret = pwrseq_unit_enable(pwrseq, pos->unit);
+		if (ret) {
+			list_for_each_entry_continue_reverse(pos, list, list)
+				pwrseq_unit_disable(pwrseq, pos->unit);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int pwrseq_unit_disable_deps(struct pwrseq_device *pwrseq,
+				    struct list_head *list)
+{
+	struct pwrseq_unit_dep *pos;
+	int ret = 0;
+
+	list_for_each_entry_reverse(pos, list, list) {
+		ret = pwrseq_unit_disable(pwrseq, pos->unit);
+		if (ret) {
+			list_for_each_entry_continue(pos, list, list)
+				pwrseq_unit_enable(pwrseq, pos->unit);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int pwrseq_unit_enable(struct pwrseq_device *pwrseq,
+			      struct pwrseq_unit *unit)
+{
+	int ret;
+
+	if (unit->enable_count != 0) {
+		unit->enable_count++;
+		return 0;
+	}
+
+	ret = pwrseq_unit_enable_deps(pwrseq, &unit->deps);
+	if (ret) {
+		dev_err(&pwrseq->dev,
+			"Failed to enable dependencies before power-on for target '%s': %d\n",
+			unit->name, ret);
+		return ret;
+	}
+
+	if (unit->enable) {
+		ret = unit->enable(pwrseq);
+		if (ret) {
+			dev_err(&pwrseq->dev,
+				"Failed to enable target '%s': %d\n",
+				unit->name, ret);
+			pwrseq_unit_disable_deps(pwrseq, &unit->deps);
+			return ret;
+		}
+	}
+
+	unit->enable_count++;
+
+	return 0;
+}
+
+static int pwrseq_unit_disable(struct pwrseq_device *pwrseq,
+			       struct pwrseq_unit *unit)
+{
+	int ret;
+
+	if (unit->enable_count == 0) {
+		WARN_ONCE(1, "Unmatched power-off for target '%s'\n",
+			  unit->name);
+		return -EBUSY;
+	}
+
+	if (unit->enable_count != 1) {
+		unit->enable_count--;
+		return 0;
+	}
+
+	if (unit->disable) {
+		ret = unit->disable(pwrseq);
+		if (ret) {
+			dev_err(&pwrseq->dev,
+				"Failed to disable target '%s': %d\n",
+				unit->name, ret);
+			return ret;
+		}
+	}
+
+	ret = pwrseq_unit_disable_deps(pwrseq, &unit->deps);
+	if (ret) {
+		dev_err(&pwrseq->dev,
+			"Failed to disable dependencies after power-off for target '%s': %d\n",
+			unit->name, ret);
+		if (unit->enable)
+			unit->enable(pwrseq);
+		return ret;
+	}
+
+	unit->enable_count--;
+
+	return 0;
+}
+
+/**
+ * pwrseq_power_on() - Issue a power-on request on behalf of the consumer
+ *                     device.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This function tells the power sequencer that the consumer wants to be
+ * powered-up. The sequencer may already have powered-up the device in which
+ * case the function returns 0. If the power-up sequence is already in
+ * progress, the function will block until it's done and return 0. If this is
+ * the first request, the device will be powered up.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ */
+int pwrseq_power_on(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_target *target;
+	struct pwrseq_unit *unit;
+	int ret;
+
+	might_sleep();
+
+	if (!desc || desc->powered_on)
+		return 0;
+
+	pwrseq = desc->pwrseq;
+	target = desc->target;
+	unit = target->unit;
+
+	guard(rwsem_read)(&pwrseq->rw_lock);
+	if (!device_is_registered(&pwrseq->dev))
+		return -ENODEV;
+
+	scoped_guard(mutex, &pwrseq->state_lock) {
+		ret = pwrseq_unit_enable(pwrseq, unit);
+		if (!ret)
+			desc->powered_on = true;
+	}
+
+	if (target->post_enable) {
+		ret = target->post_enable(pwrseq);
+		if (ret) {
+			pwrseq_unit_disable(pwrseq, unit);
+			desc->powered_on = false;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_on);
+
+/**
+ * pwrseq_power_off() - Issue a power-off request on behalf of the consumer
+ *                      device.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This undoes the effects of pwrseq_power_on(). It issues a power-off request
+ * on behalf of the consumer and when the last remaining user does so, the
+ * power-down sequence will be started. If one is in progress, the function
+ * will block until it's complete and then return.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
+ */
+int pwrseq_power_off(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_unit *unit;
+	int ret;
+
+	might_sleep();
+
+	if (!desc || !desc->powered_on)
+		return 0;
+
+	pwrseq = desc->pwrseq;
+	unit = desc->target->unit;
+
+	guard(rwsem_read)(&pwrseq->rw_lock);
+	if (!device_is_registered(&pwrseq->dev))
+		return -ENODEV;
+
+	guard(mutex)(&pwrseq->state_lock);
+
+	ret = pwrseq_unit_disable(pwrseq, unit);
+	if (!ret)
+		desc->powered_on = false;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pwrseq_power_off);
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+struct pwrseq_debugfs_count_ctx {
+	struct device *dev;
+	loff_t index;
+};
+
+static int pwrseq_debugfs_seq_count(struct device *dev, void *data)
+{
+	struct pwrseq_debugfs_count_ctx *ctx = data;
+
+	ctx->dev = dev;
+
+	return ctx->index-- ? 0 : 1;
+}
+
+static void *pwrseq_debugfs_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct pwrseq_debugfs_count_ctx ctx;
+
+	ctx.dev = NULL;
+	ctx.index = *pos;
+
+	/*
+	 * We're holding the lock for the entire printout so no need to fiddle
+	 * with device reference count.
+	 */
+	down_read(&pwrseq_sem);
+
+	bus_for_each_dev(&pwrseq_bus, NULL, &ctx, pwrseq_debugfs_seq_count);
+	if (!ctx.index)
+		return NULL;
+
+	return ctx.dev;
+}
+
+static void *pwrseq_debugfs_seq_next(struct seq_file *seq, void *data,
+				     loff_t *pos)
+{
+	struct device *curr = data;
+
+	++*pos;
+
+	struct device *next __free(put_device) =
+			bus_find_next_device(&pwrseq_bus, curr);
+	return next;
+}
+
+static void pwrseq_debugfs_seq_show_target(struct seq_file *seq,
+					   struct pwrseq_target *target)
+{
+	seq_printf(seq, "    target: [%s] (target unit: [%s])\n",
+		   target->name, target->unit->name);
+}
+
+static void pwrseq_debugfs_seq_show_unit(struct seq_file *seq,
+					 struct pwrseq_unit *unit)
+{
+	struct pwrseq_unit_dep *ref;
+
+	seq_printf(seq, "    unit: [%s] - enable count: %u\n",
+		   unit->name, unit->enable_count);
+
+	if (list_empty(&unit->deps))
+		return;
+
+	seq_puts(seq, "      dependencies:\n");
+	list_for_each_entry(ref, &unit->deps, list)
+		seq_printf(seq, "        [%s]\n", ref->unit->name);
+}
+
+static int pwrseq_debugfs_seq_show(struct seq_file *seq, void *data)
+{
+	struct device *dev = data;
+	struct pwrseq_device *pwrseq = to_pwrseq_device(dev);
+	struct pwrseq_target *target;
+	struct pwrseq_unit *unit;
+
+	seq_printf(seq, "%s:\n", dev_name(dev));
+
+	seq_puts(seq, "  targets:\n");
+	list_for_each_entry(target, &pwrseq->targets, list)
+		pwrseq_debugfs_seq_show_target(seq, target);
+
+	seq_puts(seq, "  units:\n");
+	list_for_each_entry(unit, &pwrseq->units, list)
+		pwrseq_debugfs_seq_show_unit(seq, unit);
+
+	return 0;
+}
+
+static void pwrseq_debugfs_seq_stop(struct seq_file *seq, void *data)
+{
+	up_read(&pwrseq_sem);
+}
+
+static const struct seq_operations pwrseq_debugfs_sops = {
+	.start = pwrseq_debugfs_seq_start,
+	.next = pwrseq_debugfs_seq_next,
+	.show = pwrseq_debugfs_seq_show,
+	.stop = pwrseq_debugfs_seq_stop,
+};
+DEFINE_SEQ_ATTRIBUTE(pwrseq_debugfs);
+
+static struct dentry *pwrseq_debugfs_dentry;
+
+#endif /* CONFIG_DEBUG_FS */
+
+static int __init pwrseq_init(void)
+{
+	int ret;
+
+	ret = bus_register(&pwrseq_bus);
+	if (ret) {
+		pr_err("Failed to register the power sequencer bus\n");
+		return ret;
+	}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	pwrseq_debugfs_dentry = debugfs_create_file("pwrseq", 0444, NULL, NULL,
+						    &pwrseq_debugfs_fops);
+#endif  /* CONFIG_DEBUG_FS */
+
+	return 0;
+}
+subsys_initcall(pwrseq_init);
+
+static void __exit pwrseq_exit(void)
+{
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	debugfs_remove_recursive(pwrseq_debugfs_dentry);
+#endif  /* CONFIG_DEBUG_FS */
+
+	bus_unregister(&pwrseq_bus);
+}
+module_exit(pwrseq_exit);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Power Sequencing subsystem core");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
new file mode 100644
index 000000000000..7d583b4f266e
--- /dev/null
+++ b/include/linux/pwrseq/consumer.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __POWER_SEQUENCING_CONSUMER_H__
+#define __POWER_SEQUENCING_CONSUMER_H__
+
+#include <linux/err.h>
+
+struct device;
+struct pwrseq_desc;
+
+#if IS_ENABLED(CONFIG_POWER_SEQUENCING)
+
+struct pwrseq_desc * __must_check
+pwrseq_get(struct device *dev, const char *target);
+void pwrseq_put(struct pwrseq_desc *desc);
+
+struct pwrseq_desc * __must_check
+devm_pwrseq_get(struct device *dev, const char *target);
+
+int pwrseq_power_on(struct pwrseq_desc *desc);
+int pwrseq_power_off(struct pwrseq_desc *desc);
+
+#else /* CONFIG_POWER_SEQUENCING */
+
+static inline struct pwrseq_desc * __must_check
+pwrseq_get(struct device *dev, const char *target)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void pwrseq_put(struct pwrseq_desc *desc)
+{
+}
+
+static inline struct pwrseq_desc * __must_check
+devm_pwrseq_get(struct device *dev, const char *target)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline int pwrseq_power_on(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
+static inline int pwrseq_power_off(struct pwrseq_desc *desc)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_POWER_SEQUENCING */
+
+#endif /* __POWER_SEQUENCING_CONSUMER_H__ */
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
new file mode 100644
index 000000000000..e627ed2f4d91
--- /dev/null
+++ b/include/linux/pwrseq/provider.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __POWER_SEQUENCING_PROVIDER_H__
+#define __POWER_SEQUENCING_PROVIDER_H__
+
+struct device;
+struct module;
+struct pwrseq_device;
+
+typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
+typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
+
+/**
+ * struct pwrseq_unit_data - Configuration of a single power sequencing
+ *                           unit.
+ * @name: Name of the unit.
+ * @deps: Units that must be enabled before this one and disabled after it
+ *        in the order they come in this array.
+ * @enable: Callback running the part of the power-on sequence provided by
+ *          this unit.
+ * @disable: Callback running the part of the power-off sequence provided
+ *           by this unit.
+ */
+struct pwrseq_unit_data {
+	const char *name;
+	const struct pwrseq_unit_data **deps;
+	pwrseq_power_state_func enable;
+	pwrseq_power_state_func disable;
+};
+
+/**
+ * struct pwrseq_target_data - Configuration of a power sequencing target.
+ * @name: Name of the target.
+ * @unit: Final unit that this target must reach in order to be considered
+ *        enabled.
+ * @post_enable: Callback run after the target unit has been enabled, *after*
+ *               the state lock has been released. It's useful for implementing
+ *               boot-up delays without blocking other users from powering up
+ *               using the same power sequencer.
+ */
+struct pwrseq_target_data {
+	const char *name;
+	const struct pwrseq_unit_data *unit;
+	pwrseq_power_state_func post_enable;
+};
+
+/**
+ * struct pwrseq_config - Configuration used for registering a new provider.
+ * @parent: Parent device for the sequencer. Must be set.
+ * @owner: Module providing this device.
+ * @drvdata: Private driver data.
+ * @match: Provider callback used to match the consumer device to the sequencer.
+ * @targets: Array of targets for this power sequencer. Must be NULL-terminated.
+ */
+struct pwrseq_config {
+	struct device *parent;
+	struct module *owner;
+	void *drvdata;
+	pwrseq_match_func match;
+	const struct pwrseq_target_data **targets;
+};
+
+struct pwrseq_device *
+pwrseq_device_register(const struct pwrseq_config *config);
+void pwrseq_device_unregister(struct pwrseq_device *pwrseq);
+struct pwrseq_device *
+devm_pwrseq_device_register(struct device *dev,
+			    const struct pwrseq_config *config);
+
+void *pwrseq_device_get_drvdata(struct pwrseq_device *pwrseq);
+
+#endif /* __POWER_SEQUENCING_PROVIDER_H__ */
-- 
2.40.1


