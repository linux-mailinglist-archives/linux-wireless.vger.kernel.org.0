Return-Path: <linux-wireless+bounces-15674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FD9D7AA4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C52282810
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 04:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C08B1714B3;
	Mon, 25 Nov 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="ITMq8tnu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4440855;
	Mon, 25 Nov 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507226; cv=none; b=spe2m+rHYnFtXKONHb9pTa7lj3Ukdr8gaeJOeT9dw1LvVq33m+Qz5GU9C6MAAFFXl+aQD9Vlpw5lX8pYodW3uHly3+iZhmCeD9moPc0n5346Fsanjw+3j6BV0ZLniSLwFdiWofEuxNC9kyniWnW6k1RUs2GC0GnVmaNQ3N7Pn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507226; c=relaxed/simple;
	bh=7PPsbid4M9D/6WazRtWqSk5j/jZ4koF4s1URfKT0/gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIt4N3ZVxJRZCfGUAj0x6kmbIq8ctt0dpmk14pqOyVeumS57qztPl8zxvr8W8abKNUBK2dbItGDVUlirXvT4DtcBk5cmZyzmJQsSsw7XgEO2QCOIx49lgp8gEByx9gVFkqPeNyiWSNk0+IusNUso1sLU7OfOwL1eYCC+rbZ0mRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=ITMq8tnu; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1732506707; bh=7PPsbid4M9D/6WazRtWqSk5j/jZ4koF4s1URfKT0/gM=;
	h=From:To:Cc:Subject:Date:From;
	b=ITMq8tnuzDTC6iAarN6dtOpubSFfr6mNxyolDZgzN7bxZUN7iDDIeAtHnpB8sHf1Y
	 u33wg1+e6Xt6NbDNH/VPq7cDjN2pSsOTc069O+Nu4HRDZkWarT9XX2ipV2Aq3QQVwt
	 jA9ioSh6DsG7mIRwAGs1xzZ2unk4/9Eyp3kluSVQ=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id 5E7A41487357;
	Mon, 25 Nov 2024 04:51:47 +0100 (CET)
From: Mihai Moldovan <ionic@ionic.de>
To: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC] [PATCH v2 00/13] ath1{1,2}k: support multiple PCI devices in one system
Date: Mon, 25 Nov 2024 04:50:15 +0100
Message-ID: <cover.1732506261.git.ionic@ionic.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ath11k and ath12k suffer from a long-standing issue that is partly
caused by the QRTR implementation, which only supports one device per
node/port combination and partly caused by the fact that the
QMI instance ID of the devices are statically set to 1.

P Praneesh <quic_ppranees@quicinc.com> submitted a patch[0] that fixes
this issue generating a unique QMI instance ID based on the PCI bus data
for the device and passing that information to the QMI subsystem and the
device's firmware via a special PCI register.

However, it quickly turned out that this approach works for the hardware
he tested, but fails for other ath11k-based devices, including the
popular QCA6930, since its firmware just ignores the special register
being used.

Since we need QMI (and, for matter, QRTR) to work for the initial
firmware upload, this approach will not work generically.

Fortunately, Denis Kenzior <denkenz@gmail.com> cooked up a patch set for
QRTR[1] that introduces the concept of endpoint IDs, which are
dynamically allocated and can be used to distinguish different devices
even though they use the same node/port combination. Using this patch
set, endpoint IDs can be reported as part of auxiliary data in the QRTR
socket and bound to for client sockets, which will automatically filter
messages from other endpoints and also make sure that client messages
are routed to the correct endpoint.

This looked promising, and with that functionality, the only challenge
is to find out the correct endpoint IDs and bind to them in drivers to
finally support multiple devices in a generic way.

This patch set implements exactly that, and it WORKSFORME, but
unfortunately it turns out that "the only challenge" is very difficult
to overcome due to the socket-based architecture.

ath1{1,2}k and QRTR are at opposite sides of the socket, with QRTR
assigning endpoint IDs and ath1{1,2}k needing a way to fetch and operate
on them.

The endpoint reporting feature in QRTR is not helpful in this case,
because drivers do not generally know which endpoint belongs to the
device they currently handle (i.e., there is no central registry) and
even if we were to snoop on the socket and take the first endpoint ID we
are unaware of, this might not be the correct one, because it might be
in use by a different driver for instance, or correspond to a different
device.

The first iteration of this patch set[2] extended struct mhi_device with
a qrtr_endpoint_id field that was initialized to zero and populated by
the QRTR MHI driver as soon as it was loaded. Drivers could then query
this field through an mhi_device->mhi_cntrl->mhi_device chain (if they
also use the MHI bus, of course). This, however, was an incredibly ugly
hack because QRTR data should not be part of MHI device structures in
the first place, timing is critical (drivers querying the endpoint ID
must do so after the QRTR MHI module initialized, which is typically
only the case after QRTR socket was created) and it was not possible to
query or pre-assign an endpoint ID before creating a socket and directly
bind to it (which might lead to races such as seeing messages over the
socket that are not meant for the endpoint ID drivers are actually
interested in).

Since that was not elegant at all, and due to the other mentioned
issues, this iteration uses a different approach: endpoint IDs can now
be associated with (private) backend endpoint-specific data, which
allows us to identify which endpoint ID is being used with what backend,
and additionally new API is introduced so that other parts in the kernel
can either get an endpoint ID for given endpoint-specific data or even
attach endpoint-specific data to a new endpoint ID generated by the QRTR
driver. The QRTR system will try to use endpoint-specific data if
possible, but falls back to generating endpoint IDs without
endpoint-specific data (as in, NULL pointer) if that did not work.

Crucially, the endpoint-specific data pointer is used as an opaque void
pointer and at most compared with data stored in the endpoints XArray.

In the QRTR MHI backend, we use the MHI controller's structure pointer
as endpoint-specific data, and since the MHI controller is also the bus
master and responsible for the physical link, clients (drivers) can
pre-register an endpoint ID for their MHI controllers and directly tell
QMI to bind to the endpoint ID at socket creation time. 

The QRTR SMD backend uses its rpmsg_device pointer and the TUN backend
uses the inode pointer as their respective endpoint-specific data
pointers.

This approach is cleaner and works better, because it is not prone to
races (although it requires coordination between QRTR backends and
clients/drivers because both must use the same endpoint-specific data
for the scheme to work).

There are, however, also issues with this approach:
  - Any kernel part can generate an unlimited number of endpoint IDs
    with arbitrary pointers. The amount of endpoint IDs that can be
    tracked is limited, though, so there is potential for exhaustion of ID
    space.
  - Since previously endpoint IDs were only generated by the QRTR
    subsystem, there was no need to use any kind of life cycle management
    for the endpoint IDs: they were created at node creation time and
    also deleted at node deletion time. Since other subsystems can now
    create endpoint IDs, it would probably be good to have a way to
    reclaim created but unused endpoint IDs. No such implementation is
    provided here.
  - Multiple PCI/MHI devices will work, but no AHB + PCI/MHI interaction
    has been tested. Since PCI/MHI devices bind to their endpoint ID,
    these will likely work, but the AHB devices might still see messages
    for all endpoints and fail to work correctly. AHB devices seem to be
    using QMI and thus also QRTR, but without a specific QRTR backend
    driver (going through REMOTEPROC instead?), so this approach might
    not be viable for AHB devices.

I am much more comfortable with this patch set, even if it has some
rough edges and might not fix the situation for AHB devices.

[0] https://patch.msgid.link/20230111170033.32454-1-kvalo@kernel.org
[1] https://patch.msgid.link/20241018181842.1368394-1-denkenz@gmail.com
[2] https://msgid.link/cover.1730790058.git.ionic@ionic.de

v2: code and metadata cleanup (checkpatch.pl), no functional changes

Mihai Moldovan (13):
  net: qrtr: support registering endpoint-specific data
  net: qrtr: mhi: register mhi_controller as endpoint-specific data
  net: qrtr: smd: register rpmsg_device as endpoint-specific data
  net: qrtr: tun: register inode as endpoint-specific data
  soc: qcom: qmi_helpers: add QRTR endpoint ID to qmi_handle
  soc: qcom: qmi_helpers: optionally bind to QRTR endpoint ID in
    qmi_sock_create
  wifi: ath11k: add QRTR endpoint ID hif feature
  wifi: ath11k: stub QRTR endpoint ID fetching for AHB
  wifi: ath11k: implement QRTR endpoint ID fetching for PCI
  wifi: ath11k: bind to QRTR endpoint ID in ath11k_qmi_init_service
  wifi: ath12k: add QRTR endpoint ID hif feature
  wifi: ath12k: implement QRTR endpoint ID fetching for PCI
  wifi: ath12k: bind to QRTR endpoint ID in ath12k_qmi_init_service

 MAINTAINERS                           |   1 +
 drivers/net/wireless/ath/ath11k/ahb.c |   7 ++
 drivers/net/wireless/ath/ath11k/hif.h |   9 ++
 drivers/net/wireless/ath/ath11k/mhi.c |  22 +++++
 drivers/net/wireless/ath/ath11k/mhi.h |   1 +
 drivers/net/wireless/ath/ath11k/pci.c |   1 +
 drivers/net/wireless/ath/ath11k/qmi.c |   8 ++
 drivers/net/wireless/ath/ath12k/hif.h |  10 +++
 drivers/net/wireless/ath/ath12k/mhi.c |  22 +++++
 drivers/net/wireless/ath/ath12k/mhi.h |   2 +
 drivers/net/wireless/ath/ath12k/pci.c |   1 +
 drivers/net/wireless/ath/ath12k/qmi.c |   9 ++
 drivers/soc/qcom/qmi_interface.c      |  28 ++++++
 include/linux/soc/qcom/qmi.h          |   3 +
 include/net/qrtr.h                    |  11 +++
 net/qrtr/af_qrtr.c                    | 124 +++++++++++++++++++++++++-
 net/qrtr/mhi.c                        |   1 +
 net/qrtr/qrtr.h                       |   5 ++
 net/qrtr/smd.c                        |   1 +
 net/qrtr/tun.c                        |   1 +
 20 files changed, 264 insertions(+), 3 deletions(-)
 create mode 100644 include/net/qrtr.h

-- 
2.45.2


