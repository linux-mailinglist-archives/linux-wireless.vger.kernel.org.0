Return-Path: <linux-wireless+bounces-3976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE79861F73
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 23:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6312EB22D29
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF8D14CAC9;
	Fri, 23 Feb 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQLpXwB0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228C1F600
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726453; cv=none; b=VG5+pP1/JB8xITtkqfAzWvWeTAyH1OLBiKBSSvcbOgF4aDeTmJxda7wfBfhdgPL2sR2JMcfm6OCFCaa8/cHrunisN8qHnZczlg4KvUUHANPzA0sdQcpGxrsJcKj+tcSCQDB3rKnMKkTSbpa+NLZe+SO4i1rWUUuIWdwyyWj0p7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726453; c=relaxed/simple;
	bh=TTEB8G9p0y/YCUJukHFaBU5Cz01Opqn0rGHTMN+Q3FY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZaQHVSsoU6ZtbW0jqMof8Qg3vvzwW3dQ8jfNYA+aZ9wRnPOy0QFgGG8KN9lyuXkuED6Hzxo13/Xe3lzkVQVYDyFhJYZfHqETIw7coUpK+9M1qDibXKkW5WpsONIpR7ZQ1PE/azHkT8ytxpL3Mwmjt2TFUCcl6w39scps62U8yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQLpXwB0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NLgBGO008532
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 22:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=w5iFDVfbEvJvrd9wvU3l
	9I5/5HfbGddIwfY+VGYZY0M=; b=LQLpXwB0del1RykKjEIynk43HSdXRZ3diJRK
	F1XnK0RnibIKmGt8epvqIqrR2GWYbZzIx30q9K/y9d0MRqQynK/gXT81GBIqRSsd
	gnlx1/3Q3ZculToDDDJjG0YHwa3q4RzrgJ4/G+g7NSePscjdYufQtMPt029rLCoM
	ZrsG2fh2ewWfv7v5O89J+NaY5EEkDooX3qH+xg1qoSdEJfR+L4KaK04UbaSRcKwI
	D7o0VgajYmLbmhpfx98I5uYf2+Dcg5B8O7d6XDyD1QVQvX9YhhMHuj2Liq/9vlrQ
	Mx3zeFPMI7psxtn9oXdnjr/k9L/oKz0NEj+vmgHhZKPqF7h2eA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf3gm01td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 22:14:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NME9td032137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 22:14:09 GMT
Received: from [10.110.104.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 14:14:09 -0800
Message-ID: <181138f2-77c2-47f5-94d0-28ccd52fb166@quicinc.com>
Date: Fri, 23 Feb 2024 14:14:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: What is the lifetime of an instance of struct cfg80211_chan_def::chan
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y4ACUss3VUoE932WZLhjsyaKj3QePeH6
X-Proofpoint-GUID: y4ACUss3VUoE932WZLhjsyaKj3QePeH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=581 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230159

I'm concerned about a potential race condition in the ath12k driver, but
need to understand the lifetime of struct cfg80211_chan_def::chan to see
if there is an actual issue.

This is the target of my concern, which at first glance looks benign:
static int ath12k_mac_vif_chan(struct ieee80211_vif *vif,
			       struct cfg80211_chan_def *def)
{
	struct ieee80211_chanctx_conf *conf;

	rcu_read_lock();
	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
	*def = conf->def;
	rcu_read_unlock();

	return 0;
}
Note: I've omitted some error code that isn't important to this discussion.

This code starts a read side critical section, gets the config from the
BSS configuration, makes a copy of the conf->def and then exits the read
side critical section. What could go wrong? Well what is this conf->def
that is being copied?
struct ieee80211_bss_conf {
	struct ieee80211_chanctx_conf __rcu *chanctx_conf;

struct ieee80211_chanctx_conf {
	struct cfg80211_chan_def def;

struct cfg80211_chan_def {
	struct ieee80211_channel *chan;
	enum nl80211_chan_width width;
	u32 center_freq1;
	u32 center_freq2;
	struct ieee80211_edmg edmg;
	u16 freq1_offset;
};

Note well the following:
	struct ieee80211_channel *chan;

This is a pointer to some memory. During the time we are in the read
side critical section we are guaranteed that, if this pointer is not
NULL, the memory backing this pointer is valid. But as soon as we exit
the read side critical section there is no guarantee, at least not one
enforced by RCU, that a writer might update, or even free, the memory
referenced by chan.

So I'm trying to determine what else, if anything, protects the lifetime
of this pointer, and I'm getting lost in the mac80211 code, so any hints
would be appreciated.

/jeff

