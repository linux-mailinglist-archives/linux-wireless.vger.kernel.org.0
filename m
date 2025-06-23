Return-Path: <linux-wireless+bounces-24344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B9AE3857
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 10:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DA316CA48
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B28202983;
	Mon, 23 Jun 2025 08:27:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8081D86DC;
	Mon, 23 Jun 2025 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667232; cv=none; b=BLhXSS6Z2OCfEJ8oBwS0bUn551uFvF8XsWfsdwh/vhYn37ffHKYFfAYsM3afMTmpy1NdkASBTIzOjUeEFEzzRu5sf0nAtBQV/STVDWqgvUlBEeLlyRjzc6LhCRQo63kr8aemMWfVzX/zMEWvvDXETf1WXmQbomRGI1lwRudiods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667232; c=relaxed/simple;
	bh=I2RHzOCqZiz/ej3QKR8ozrRKNcND3ktYGlOZ9oF0vjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6SUAhgaXnoetn8BlbhoC5fEeQLF60t5LMfvzVlHXM6WnShMqouGuMSc1EZhPD7jevGqHu1min539fwivoEciNBD92MU23x0urdXBap01QXXlUYQqT1gDWHqgEE0Sxq3HWwCqElXlkLLi36lSRoj/kOwW/DAWTXdLS0mr9++1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4PIbB002542;
	Mon, 23 Jun 2025 01:26:30 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47dv8mh76g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Jun 2025 01:26:30 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 23 Jun 2025 01:26:29 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 23 Jun 2025 01:26:26 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <johannes@sipsolutions.net>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <lizhi.xu@windriver.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>,
        <syzbot+189dcafc06865d38178d@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] wifi: cfg80211: Prevent comparison with invalid registered dev scan req
Date: Mon, 23 Jun 2025 16:26:25 +0800
Message-ID: <20250623082626.3104528-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c78aef54d57a83c874cd9092d6e50c3656540c02.camel@sipsolutions.net>
References: <c78aef54d57a83c874cd9092d6e50c3656540c02.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA0OSBTYWx0ZWRfXytO55s3AmuW+ 5c9xZvno/Wq+dmEhwmr/i0zJOomjW0yVSOXymGUZzD5mmRysMIU8IpHFj+YB8+AopneMsxP9Ldg wTCOTaFhNgiQe8k5hGC7wYnUzhLyKKwE5a8Sa3kcQzg5aN81vtlNVkR6MkK/gLFa4/t3IzDFTwa
 d8zuiS5Vo5zg3sDsS/zO63Lg+ztFrBfH9f74yOSAhogWiTQlp4V5Xt5/Jlx/KdBw5RbEQ4z5nWO nmVdv7we3uoz3t+VkRn0hSewSOpov4Tk2p0rv8t/bkUJA8eDYdqm1WCgxGadLtw3meKb8JVAixU fnN90fNt4jxTb8rF12cD990hK4oH6gpdAf5JLAIyx0G+LIqWirzCwVEo+5iw3EY+oF+vYIwU8YM
 hQEifrgquMbbXPKZbTiJ4e2MX0mFYO0QDNCx8dQZhswNvdhBkCORBn6jgGwgWI/1hs9rI4Ct
X-Authority-Analysis: v=2.4 cv=MeNsu4/f c=1 sm=1 tr=0 ts=68590fb6 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=6IFa9wvqVegA:10 a=J1YBbKYVWwK1OX1Y3BsA:9
X-Proofpoint-GUID: vIrRGiyC5ypHUKuL2kgVxH63CP1OPy0e
X-Proofpoint-ORIG-GUID: vIrRGiyC5ypHUKuL2kgVxH63CP1OPy0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=493 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506230049

On Fri, 20 Jun 2025 13:01:51 +0200, Johannes Berg wrote:
> > The scan req of a registered device may have been released, so it should
> > be checked to be valid before comparing it with the current req.
> >
> 
> I don't understand the subject/commit log at all. You're now accepting
> scan_done() with a NULL scan request, why does that make sense?
It is meaningless to compare the registered device with NULL scan_req with
the current scan request.

Because there is a check for scan_req being NULL in ___cfg80211_scan_done(),
cfg80211_scan_done() is not directly exited when the scan_req of the registered
device is NULL.

Lizhi

