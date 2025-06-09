Return-Path: <linux-wireless+bounces-23849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA6AD1BDB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C11188DE0D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97885255F22;
	Mon,  9 Jun 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idQykFjQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFB253F1B
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466313; cv=none; b=ufEosmU0kZQYzUEjNRAVnKXK/AcB7q1kGNkWuoKISGTM488TKyBzpZC1yt/wiy4+hYGSWGxHnx2ANOe9r7UOIOgJJuhgbx7eNXNUjekPuP1wzF/F24QfEfdIiaLZGKP4YP18hH0ziq5WxrkqU+oaBZkZ3+IJ4oX6a1C9qhJM06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466313; c=relaxed/simple;
	bh=X8kM5XQ2zNivc2GPNSP+hcWuDzJRXGt58sYRPrO37J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cuOk/ZWp8RLd6cPukksUqxoFFb4/9LoxIoDziAb7tFmFODzC16ApXiytAplfh2pQqwOWfthq2bj0wX0PFVWLODEqsgkwVH+YJYfB8J++Zcc03KYEpUUtyOKEgQ2ufZ/WoKl4Bt5/PsjrkIMNtX+atZ19Wg6QDzJ71UgQoyGV+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idQykFjQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559352RH020102
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 10:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	trXmmTb9+iQtXzXsm6+OYyYTJ/Ijwx/r7anuZ7WDjWw=; b=idQykFjQhxREgavt
	ro8BulEdWnm3vFkJ63ijYl+aXpJIMBTqI/qBNiI5EsWEO0hXdMvilhUrx0ApIsPj
	kMVrcEejbzR5/uNyazzsHhgA8cZRfgvg2d3FtGskVKHzUiEKBaEnJWZbsALja+hO
	INu+TE6JfahJDswk87f3nq5q4kI+9S92ehij2Nsc1zKRrfgXOc+1mQu14Y6FmijC
	j9XawrDyM7UZDeaGqlhSRSWagIwtZ81Y1fgqEK/wiDOPowuBvwc2euxKd4x8aYJD
	OqfxRhix+vYsVY1nri77MoarKmzqmzCP3OaeuyfcRMd+wlRhy+7pahAyucjMbmEU
	cX7Phw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475qcts5yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 10:51:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2358430be61so37136325ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 03:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466309; x=1750071109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trXmmTb9+iQtXzXsm6+OYyYTJ/Ijwx/r7anuZ7WDjWw=;
        b=oy5/WnVgcUw5ruXRFuUtEBG14BZxcQCZS3ieV/oagux43pqJs3vU/N3QWt8jwsHCHh
         7pVC2GdyF9CKq8nYBCIWToE03TmB51bfmz+SuHqP6w/TzOBE07akBhlY63gxv4fQQdwX
         hpZU3ySkjl+y4jnJfpFhLyMXqhGg4QfStp7fP4O+zX9JHk0fthkfMD1ugvrtgdX0zGjr
         SeHTnqGqoAg6jdOCMEweoJU3n0i8twV+K3dkJPsvBf07hS9CGjiNHsp2mCDpKzo2UUXE
         1Giuj4wqzIfiendsamnAOARv2x60HS24xuHu1TK+CIoGFOQk08u0cyHYcNI8ctDDnXfX
         yK5w==
X-Forwarded-Encrypted: i=1; AJvYcCXy68zus66CtLZoqVnsGW1Km5/0Wd65avZ/+EEqSZSi1+NU4r5dg5FPwUU19TcoJ6mM+vkfCBK3AMeRO9bLvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RooCe8f5jWV+imsSfKdQ1bHGHGYj5OeAMMDe5bURPCRImA3M
	RK/r5LKaYUnuH5xoDHAcC4n5iSmFh6eUW+/T0cNjkSBW8a4ZklN6UA7RAVVyMCpoCDFyQhfcgBc
	PtoTbeVWAUOSrloyXVIUv6hXcIxqn4FiYq10VrneGYCw4kpWVPGLwi2WfZLwIN0RGqtofzQ==
X-Gm-Gg: ASbGncvnmQOjbnttETkyv3fnsmhKRq0fyV5beYNV/OVoj2KjB64fD9r+m0VJYDJme9x
	+ic0P5h//8hR7kGL9lpGuZ0ZcDQmh9OSrYbWah5AVlp/fGQ4c2+/iB1MIP345lPgECDR2yWbXeJ
	UiC4g2XFyFjYtEsYlGYmiUfznLi58JU7RwFmphasuTSzzeTAHZ8NmxRhEIYTDZ/PenzOBZVy1p0
	aX1DFDExNJNSwudcz0l+UFuMqsT1mG8EFz734+xpDp7uqkWQTpqYDrvykILfNiIU2Z6Ef7zp6zc
	rQF1EBUI0NWY1Bit4BSa1CzdwHWqMqfJb7JdUzmazbqUt54=
X-Received: by 2002:a17:903:2f89:b0:234:f6ba:e68a with SMTP id d9443c01a7336-23601deb581mr175174305ad.45.1749466309321;
        Mon, 09 Jun 2025 03:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVIBaL6LFV+aORegVX21PIPCDgyOLJwe970K4Psyui5I5RzzMmiu9YvY/qJul52CvnRP4MyA==
X-Received: by 2002:a17:903:2f89:b0:234:f6ba:e68a with SMTP id d9443c01a7336-23601deb581mr175174135ad.45.1749466308958;
        Mon, 09 Jun 2025 03:51:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:48 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:23 +0530
Subject: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth before
 & after link re-training
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-2-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=4213;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=X8kM5XQ2zNivc2GPNSP+hcWuDzJRXGt58sYRPrO37J8=;
 b=44trExxx+0SnN8VK1fum6kk+5lB/Y8962mnM92Ux5aBz/J1awGcAPvV4X7K9NF1edQMrkzXZk
 xjn3VZksWO0DreDpPSZuPv/AKS7y1vUXKk7gZYK6ODu2L0/4reTmKin
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 6AfwogHA9NZi_V34CZ_Ch58ZELpg32Ii
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=6846bcc6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=AH_oHoLqry_2ofrPVhgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfXw3BbyyA83iUF
 xZ/uCVtgs1NTRhEW0SLCnof6vAiwEMn0R9iPS9B13qTpYrIPKg4CJwoOuB/TVSR+jNTLYV3A9xi
 z9ALQAdPPLVfrG9a6uVhraLkgBHgvfbQVW5dxHNJV3L1iCQtHggrHIrz0shdv7MpmeJZwQ48NaW
 E3+QN/8EzTYFgTdkn+3Zw9zNcWBrNiIYJGu7iXYjGP7fRiql0vI4MwJGClSpqbRdYwo5uoTrg5p
 ukx7OPqNpv8VHLSHqHz+NJoMyALs031yNSM4/9zQoU+esfhBf76EX3QjIltFJh2z69RheeoMSva
 8VwKT4pilDohFiJpzrTQp7CWM6kX91jvOdDOSsB3u+BXEEaZyl3MKCcS4ssrqFE03EBskwq8lw+
 TdR4+x08szCPwL81tQGs3JJY4YvL4e6oaGY4QJIdj6OZ2k9mVroBaYAPL8TyWGdxekbWijSO
X-Proofpoint-ORIG-GUID: 6AfwogHA9NZi_V34CZ_Ch58ZELpg32Ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090082

If the driver wants to move to higher data rate/speed than the current data
rate then the controller driver may need to change certain votes so that
link may come up at requested data rate/speed like QCOM PCIe controllers
need to change their RPMh (Resource Power Manager-hardened) state. Once
link retraining is done controller drivers needs to adjust their votes
based on the final data rate.

Some controllers also may need to update their bandwidth voting like
ICC BW votings etc.

So, add pre_link_speed_change() & post_link_speed_change() op to call
before & after the link re-train. There is no explicit locking mechanisms
as these are called by a single client Endpoint driver.

In case of PCIe switch, if there is a request to change target speed for a
downstream port then no need to call these function ops as these are
outside the scope of the controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
 include/linux/pci.h       | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34e8a3b25a2d1b9059e015f298ca94..dafb8d4f1cfba987e1ff08edfc7caba527f0c76b 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -140,6 +140,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
+	bool is_rootbus = pci_is_root_bus(port->bus);
 	struct pci_bus *bus = port->subordinate;
 	u16 target_speed;
 	int ret;
@@ -152,6 +154,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	target_speed = pcie_bwctrl_select_speed(port, speed_req);
 
+	/*
+	 * The host bridge driver may need to be scaled for targeted speed
+	 * otherwise link might not come up at requested speed.
+	 */
+	if (is_rootbus && host->pre_link_speed_change) {
+		ret = host->pre_link_speed_change(host, port, target_speed);
+		if (ret)
+			return ret;
+	}
+
 	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
 		struct pcie_bwctrl_data *data = port->link_bwctrl;
 
@@ -176,6 +188,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 	    !list_empty(&bus->devices))
 		ret = -EAGAIN;
 
+	if (bus && is_rootbus && host->post_link_speed_change)
+		host->post_link_speed_change(host, port, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
+
 	return ret;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..1740bab514b0a9a61c027463a1fb154843312a22 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -599,6 +599,24 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	/*
+	 * Callback to the host bridge drivers to update ICC BW votes, clock
+	 * frequencies etc.. for the link re-train to come up in targeted speed.
+	 * These are intended to be called by devices directly attached to the
+	 * Root Port. These are called by a single client Endpoint driver, so
+	 * there is no need for explicit locking mechanisms.
+	 */
+	int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
+				     struct pci_dev *dev, int speed);
+	/*
+	 * Callback to the host bridge drivers to adjust ICC BW votes, clock
+	 * frequencies etc.. to the updated speed after link re-train. These
+	 * are intended to be called by devices directly attached to the
+	 * Root Port. These are called by a single client Endpoint driver,
+	 * so there is no need for explicit locking mechanisms.
+	 */
+	void (*post_link_speed_change)(struct pci_host_bridge *bridge,
+				       struct pci_dev *dev, int speed);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.34.1


