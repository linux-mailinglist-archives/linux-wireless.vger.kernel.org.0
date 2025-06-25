Return-Path: <linux-wireless+bounces-24474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906DDAE7ED1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A2D189DA0B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A070E29B761;
	Wed, 25 Jun 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SrelEpe4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84692C1798;
	Wed, 25 Jun 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846299; cv=none; b=b9g+5rzKnwHFssQ6xyS5HzE2FJYdaXTIPjhlw9c4AAEJEclPtTiavPY3PfBs0uhNkVQ86/nhm19QSxs2OH0pyDtZstyENlkQ9zNTyA9Jp4kP9CTFpJUlvWdxL566pFSU5g27NCblhvfdg6dr9zMArHB4RAoDnbiK01UtCV5/mWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846299; c=relaxed/simple;
	bh=Pt2A6du1suQCqRB8SB2UukGUrSYx890Nj162A4lyWrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ovd4pJmj+eezqxF3aUlEutSMVb/1bheObxzlnBKkOpk6Jc579i4z0SqeFK5jfjDHqM+m/sufMYPk3IrbkX9rKkaybTuu+PAWHpl4YQaW/XYuPu6TsJofeNfuYTByaTJIUMCqyc29ShR482v/G9IJbrExrrEHkgZfX/U97pvVqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SrelEpe4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P5acAc015282;
	Wed, 25 Jun 2025 10:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKQLKMUky5WHqaoYs0T+b5nQqdqDBFh7xSwwyxzYvdU=; b=SrelEpe4//zi4NGe
	qLjdpp/ScxF1LjtrVnV+RICkYnfPxbIPsuWqWg+cL10Zn/ds+x8wX0623igV0xpm
	4W74EMVaEZCIQ6DG3Mjxyv3HJrEFmnzJ5zC975OJT5y3+iKgFahImgJaa9nM8y9Y
	7JqZKi+nPcg93/6rUksxmFilxoxDJxzMGfi0AdwJXc6cqnUkA1/vjSPvAdVOKT28
	xvHNN4zQJfM4LboHs8DAdIKt4fbPiP5CADgxYhMRZKRNvkUbdl+7Ak0d1VHyoeLk
	Cz2pkpegFN/PDLq4xfAyfjyC9n8rZbBPd1beiNKIEVVbnBjt3JApXOXErKXDc83D
	jPnB0A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4rpc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:11:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PABReY023222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:11:27 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 03:11:26 -0700
Message-ID: <68ed28c9-66e8-4f7a-870c-97597f211548@quicinc.com>
Date: Wed, 25 Jun 2025 18:11:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no AP
 is associated
To: Johannes Berg <johannes@sipsolutions.net>,
        <miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>,
        Zhongqiu Han
	<quic_zhonhan@quicinc.com>
References: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
 <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
 <5e378fe7-90ec-4453-b549-1106f9d0cfef@quicinc.com>
 <89dd111db62029f1575f7a7113e2a0cb5a1a8d5f.camel@sipsolutions.net>
 <d63e5f8a-8e0a-4619-98a8-e73c80e307cd@quicinc.com>
 <4d62cb5cd352ffc7c23be18b208865798137b966.camel@sipsolutions.net>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <4d62cb5cd352ffc7c23be18b208865798137b966.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685bcb50 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=edf1wS77AAAA:8
 a=XY8bM611AAAA:8 a=khReEpxINQUgqkxWVuAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=t7jRrxMttnDnNWY1o8da:22
X-Proofpoint-GUID: 00JIBCX54fLbk-gzxHyMTZ716xQ8Ef_f
X-Proofpoint-ORIG-GUID: 00JIBCX54fLbk-gzxHyMTZ716xQ8Ef_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NiBTYWx0ZWRfX/hAem9scQlnA
 9VhVS7c7J3ELwidi3msbZaOSMrKxRXY3osEY3dAP9GI8Vs4wHfeK8SwNfP1P+AxtTJ329Of3UOS
 KdrgnCaoPvelUs4yS27pN6bh7Kzs+5Cyh/d+FGSCu7Zu7dWN6hXRAHAd7o/l4Su7uLTE/VWxiqo
 Vv3YcPFy7Twd1QREFm1HRmBM9/qZMiTt4l7+yU1Oxss48XtGiY0sJYNP12k0K38xsnMg/kgB0g9
 ir1Wjc53g8m/ObEnbLhTvLkSAIcxyRxuPKVjMnJLThzgFQ+yyUx1gd4P/iJOwH90RQmyQS6uwlU
 8SieqvBlCtTk3gFYkxdre6ynPU7hYekGAyKqO6u0xPz09pJCv1OkEIEQQMqd1Afk1hJ1nGmqkMn
 lmvftbk63Z7q7eN12szax/R75d2DE9qVdULpufEUGTefiCisFd/4kIQNdc4pMyMSfEVa4BJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250076

On 6/25/2025 2:45 PM, Johannes Berg wrote:
> On Wed, 2025-06-25 at 11:58 +0800, Zhongqiu Han wrote:
>>
>>   >>>
>> We have this WARN_ON since 687a7c8a7227
>> ("wifi: mac80211: change disassoc sequence a bit")
>>   >>>
>>
>> this WARN_ON was added in func ieee80211_set_disassoc() but not
>> ieee80211_report_disconnect()
>> I add WARN_ON on ieee80211_report_disconnect() on my patch v2,
>>
>> It was precisely because of the WARN_ON at 687a7c8a7227 that caused
>> ieee80211_set_disassoc to return early(when panic_on_warn is not
>> enabled). As a result, ieee80211_set_disassoc failed to properly
>> initialize frame_buf. Then, when ieee80211_report_disconnect was called,
>> it ended up using an uninitialized value.
> 
> Sure, but now you're talking about something that's not supposed to
> happen. The WARN there means "someone made a mistake in this code". I'm
> not even super concerned about using uninitialised memory in that case
> although I agree we should avoid it, so the trivial fix for the data
> leak, without making the logic more complex, would be to just initialise
> the data to zero. Not to fix the syzbot issue (which btw is already no
> longer happening according to the dashboard), but to fix the potential
> data leak.

Hi johannes~

Thanks for your discussion~

I really appreciate your review and don’t want to take up too much of
your time.

yes, potential data leak issue should be fixed.

> 
> Since ieee80211_set_disassoc() returns early only with a WARN, with
> syzbot you won't ever get to the uninitialized memory use though, which
> is what I was asking.
> 
>> The bug was triggered as follow:
>>
>> Commit 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit")
>> introduced a code path where ieee80211_set_disassoc may return early if
>> WARN_ON(!ap_sta) is triggered(panic_on_warn is not enabled). In this
>> case, frame_buf is not initialized.
> 
> No ... that can't be right, we _know_ that syzbot enables panic_on_warn.
> So this particular bug report from syzbot is definitely _not_ triggered
> this way.

Let's revisit the initial stack trace where the problem originated.
the issue occurred on commit:
HEAD commit:    ff202c5028a1 Merge tag 'soc-fixes-6.14' of git://git.kerne..

=====================================================
BUG: KMSAN: uninit-value in cfg80211_tx_mlme_mgmt+0x155/0x300 
net/wireless/mlme.c:226
cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
ieee80211_report_disconnect net/mac80211/mlme.c:4238 [inline]
ieee80211_sta_connection_lost+0xfa/0x150 net/mac80211/mlme.c:7811
ieee80211_sta_work+0x1dea/0x4ef0
ieee80211_iface_work+0x1900/0x1970 net/mac80211/iface.c:1684
cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
process_one_work kernel/workqueue.c:3236 [inline]
process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
kthread+0x6b9/0xef0 kernel/kthread.c:464
ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable frame_buf created at:
ieee80211_sta_connection_lost+0x43/0x150 net/mac80211/mlme.c:7806
ieee80211_sta_work+0x1dea/0x4ef0
=====================================================

frame_buf is created at ieee80211_sta_connection_lost()
and the func is short:


void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
				   u8 reason, bool tx)
{
	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];

	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH, reason,
			       tx, frame_buf);

	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
				    reason, false);
}


In func ieee80211_set_disassoc(), frame_buf will never be NULL, so
ieee80211_send_deauth_disassoc must be called if
ieee80211_set_disassoc() not return early.


	/* deauthenticate/disassociate now */
	if (tx || frame_buf) {
		drv_mgd_prepare_tx(sdata->local, sdata, &info);

		ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
					       sdata->vif.cfg.ap_addr, stype,
					       reason, tx, frame_buf);
	}


I also checked the cmdline from kconfig, there is no panic_on_warn on
kernel config:  https://syzkaller.appspot.com/x/.config
x=aca5947365998f67

However there is possible it is partial or not used cmdline as
CONFIG_CMDLINE_FORCE is not set.

CONFIG_CMDLINE="earlyprintk=serial net.ifnames=0
sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack
ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack
sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack
sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1
rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on
sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4
secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off
coredump_filter=0xffff root=/dev/sda console=ttyS0 vsyscall=native
numa=fake=2 kvm-intel.nested=1 spec_store_bypass_disable=prctl nopcid
vivid.n_devs=64
vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
netrom.nr_ndevs=32 rose.rose_ndevs=32 smp.csd_lock_timeout=100000
watchdog_thresh=55 workqueue.watchdog_thresh=140
sysctl.net.core.netdev_unregister_timeout_secs=140 dummy_hcd.num=32
max_loop=32 nbds_max=32 kmsan.panic=1"


Although I suspect the if the syzbot has indeed enabled panic_on_warn or
not,  the most important thing is to avoid data leak and also what I’m
concerned about might also trigger a WARN_ON on ieee80211_set_disassoc.


> 
>> Later, when ieee80211_report_disconnect is called, it attempts to use
>> the uninitialized frame_buf, resulting in a bug.
> 
> I agree this is a bug but it's not one that requires major surgery to
> fix - the only bug here is that if we already have another bug that
> leads to the WARN, we can leak stack data to userspace. We can simply
> initialise the data to avoid that. I'm not worried about reporting a bad
> thing to userspace if we already had a WARN indicating some _other_ bug
> that we should fix.

Sure, I got you point~ maybe the only thing we need to do is avoiding
data leak to userspace side.


> 
> 
> I'll happily take a patch that says "initialise the frame buffer so that
> on the off chance of other bugs, we don't leak stack data to userspace",
> but I do think that's about all we need at this point. The syzbot report
> is already stale and no longer happening anyway. If there is another
> report about the WARN_ON after commit ccbaf782390d ("wifi: mac80211:
> rework the Tx of the deauth in ieee80211_set_disassoc()"), we need to
> see how it's possible that we get into the WARN case, but I haven't seen
> such a report.

Sure, I plan to arise one such patch to initialize all the frame_buf on
net/mac80211/mlme.c file.

Thanks johannes for the nice discussion~

> 
> johannes


-- 
Thx and BRs,
Zhongqiu Han

