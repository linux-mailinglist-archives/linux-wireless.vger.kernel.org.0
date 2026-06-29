Return-Path: <linux-wireless+bounces-38255-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CDm7FcoRQmrJzgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38255-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:33:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1C6D65C6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BYwvWo9J;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dw98yiOK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38255-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38255-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5807630057B8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026182D838E;
	Mon, 29 Jun 2026 06:33:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902238AC7D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:33:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782714822; cv=none; b=FzoGDPD4VfmkcErlxa6GeKs6swBJMBg30EgZKKByVyo0F8rzO0SSBxnO0rTDtyYjquv7to4wx0wsruHotxG1KWj+YHP+mC1koCxjBVswuTwvaH7uMANnaWKoifnzMdBYWNLAJw/mKZGZozJh6Hxbv6zFfZBQJ7mAlrJMr6lkTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782714822; c=relaxed/simple;
	bh=FL17MttsLDTboYC4ZL2LqoXy459gzvmmHCFat/hnwqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBQ/vcrh8uvZUC7ZrlfiKYufRvvqJwPhjLU5MTuUGJEL92O7XyNT/zeE52qAEQ8VkCzOs/1+oxxbFmfZ3EH2UMpU4TDtCwjvZEDNOmBMCw3Ju1IhYi/A1B9FYdawNVoUV0ybVbBhXksHhW6l30I6BZhzRIYxh6Q7JEIFb30DYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BYwvWo9J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dw98yiOK; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NKph1781034
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+RKzJVfoiFDtEnwN4s74G0WMVxZbpbshRPYvjX16kZY=; b=BYwvWo9JjKTddEm0
	0vGO5ZrxP3TTGY5BvOa0rqI2VbKTJj99sk3bWrMEn8dnEhtjhA0v7O0jii75eMKN
	uy7RZC0wsEZbYNyY/+ipsKyOU0cEJPYo20UNoFC8FCPdWG8TCBJTl+S1ZF5HnzLC
	iLrB8G0aEi9umUuS+oZyYkX4j9LpP/eJWwUfJMPHpEY9vAEUl5tema1Vr4g0+RGa
	plDtXVkKMIjIitFmB73ockEGEiarevkOQ+awLVttgMSv/G5Dclf02L+tUZxXn+zf
	q2/SYlf/ik/YOXemR5FlEPDEsW8MaEqMFUacmdhKENNQUyeub1ecSsBffv7oGMYm
	O7cNRQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u75019-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:33:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ed664e368so135084eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782714817; x=1783319617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RKzJVfoiFDtEnwN4s74G0WMVxZbpbshRPYvjX16kZY=;
        b=dw98yiOKtp32YPdZMz+nB6ZIhtEBE+uI/iTaneFLLB+bNeLSVkZLvVGt8ZgUQpNmnF
         wxR10EOFOro32VjuMS5W/wwN8alW0tXRClguS9HEXEuTQtq++lAL4V4B9YHSWJ5lQo62
         0dPUIapDgi14KqFbtSiYHDXTlpwikqRHikF9GqtAgXKCzFplKByv9D2PpQqP42jmL1+v
         N5Wl2FKzR92MONGdqnuuFMetEvff42wqdRn6UFLd+nr/f1+5qXnwUN4evde5OHuILH70
         BZNMB1PuR0vseZxzZkXfDpL2qfaKZQqrIlmwk3WRlte8TR8OAr4JOU/AyxwEm8+KZSVE
         +ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782714817; x=1783319617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RKzJVfoiFDtEnwN4s74G0WMVxZbpbshRPYvjX16kZY=;
        b=NkSv65wATKhRIPgwd6mEw1paM4c1/NsKB4kKgVlv+yEZ2fX8GWogkpR9VR+DJIAWKA
         h3aigMfgAcIBJAj6nx0qRpxOtnBoqEeXyz36QDzWYwBIa2U7FWKnS18kyTN/vCu8JaV2
         VnPnTaZP3iyW5nYGTf38h6YcYToWvzzKXjMWG3L5d0QXNC+0sOf2xhs3iBKATNVs3HTg
         44u859BNg2F1riGboSeM6PbSyUzUUr1A5vjTTvlBzKMn8iEQvkM0qZGqjdPLn+cREn8S
         XvpoKbgPb0GAUh4xMfgyagQquRKyA8HmGXJ4MmIKc+rGvaEbQLwo1D7GuhFfowU1GNBD
         d+8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrwUbs6kja8eZtHxc3pfvvkoXVUVScwMaFZq3H+6Xna1tSa+ZkOxq4HkJ+4VtXxZi+M7/fILpTPXWxceoQiHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznB6fbEi34BfAQUtzbyecEt81JIjz7CbrjrVEIQ8hhE5uoh9Jc
	clPe8pCAzmd9gTZpNQxbvXCHswg1A71Ba+wibGMfpdvbxzt5tOGw8wQXEnNnfuCfyYe4sWbCICw
	eglZ+bZxZxgK8SRWXaOGY/9tQb6lMpk7hSbY2COrzZPIyapwOSLh1b1t6ccsW/NAKCBK3hg==
X-Gm-Gg: AfdE7cnvMHgK6P3KKt+2yujMhVyM4A0WtlAzMMGjdc+8ZzVyByhbYpOX24zOgAVRrB7
	/fGcLjEQWHWFyIpGinfyvKBUe1CWyNoSKuafrjPdoytOKQQNjyiaX1EMt2/V1dGJUArtMXXy5RL
	9paj39Gc98zgwhxM6fAdwccFdhFQZeWwiNfRdxJ7ANlBwnrL8wMPuiJU0tzbc7ey4uRm3D1QK7L
	dPEZDMOZNrpC0rIUDS+FM2da10q7RtvjygGXhZh/MEPSBJldiB/fWfaf8YwmuKhgXIo4NNUp7zq
	aqIg0HeSsw99nMDbvIuOE+xR+2gewXAQfVKO3g0C3j5KyeAitcV/cqebo+8Wdz4yx/VeCQSd4eo
	lhKMn9lVIdawiHu9uNyCMec1911geopof+cGf0oAJEa8=
X-Received: by 2002:a05:7300:a485:b0:30b:8878:9c8e with SMTP id 5a478bee46e88-30c85468412mr14119919eec.2.1782714816622;
        Sun, 28 Jun 2026 23:33:36 -0700 (PDT)
X-Received: by 2002:a05:7300:a485:b0:30b:8878:9c8e with SMTP id 5a478bee46e88-30c85468412mr14119867eec.2.1782714815210;
        Sun, 28 Jun 2026 23:33:35 -0700 (PDT)
Received: from [10.204.117.168] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca438ddsm41024257eec.23.2026.06.28.23.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:33:34 -0700 (PDT)
Message-ID: <fee56590-36e3-475b-b6dd-118fffcf3d02@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:03:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: cfg80211: fix regulatory.db async
 firmware request blocking __usermodehelper_disable()
To: Carlos Llamas <cmllamas@google.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <20260625092904.2097371-1-kavita.kavita@oss.qualcomm.com>
 <aj6QvBdf3hGzDQig@google.com>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <aj6QvBdf3hGzDQig@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1NCBTYWx0ZWRfX8WqePuu/ziYq
 itmy2T9I0jW0FQzQLolld1/FX1T+cLJyPFMUgR7jvz/Jld8Y2CimR4Gw9906BsL20elIFfloll5
 vLGv/H9Jocdvn9Xs6bsSvfgRP4mKgL8=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a4211c1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-as5wUAXeyAFUtXTAA0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Y-71ytMy0Q1ndKtos9KiBzLdHncAU-zx
X-Proofpoint-ORIG-GUID: Y-71ytMy0Q1ndKtos9KiBzLdHncAU-zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1NCBTYWx0ZWRfXyTr87RbReLt7
 xQ2psPEBwSo1p5jWVUbxhwgYqWwWkaHApWpW/pt+BVJddLPGbbdVoCgtJxS8q6293e1juJTKrQY
 tKXp4j/pDTiviOUmn5uEd+yMWDX35aU/nG7NAaCY5EMBMkSVBpKXtV7RrB1FyGe51PYjdqiF56O
 lP0D91wpMMCD5OosbmqTvMOUHEhU6LkH6MkUbvgFoNw+FZhEmo3s8HbecrwcmlwPvFCVAM6rRZx
 hR/f+F+26ya1Ibwo2oaxlVcG4hEKbnX6mU1qgsmaSG5ZggU+wEzWdVkpTSi4QbHxrLkBw3q/vKa
 p0qwbmGDdlunDwEzwwHSJEfTRSV2Bo/PNj6VqBUFdIPJYcNHnl/U85819k5/T7ZZWsrPBaCkMn0
 8dwBaKGLUTDxZrsnn2PNn7E/YZCPXJ3Od04wAYdVuA6eFOLjUyuvYgKXfFexri0+ufYKl0qMYUn
 Q9Ii1QtkrZT2imG6Q/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38255-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cmllamas@google.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AA1C6D65C6



On 6/26/2026 8:16 PM, Carlos Llamas wrote:
> On Thu, Jun 25, 2026 at 02:59:04PM +0530, Kavita Kavita wrote:
>> cfg80211 schedules an asynchronous request_firmware() work item for
>> regulatory.db via request_firmware_work_func(). When the direct
>> firmware load fails, _request_firmware() falls back to the sysfs
>> fallback path via firmware_fallback_sysfs(), which blocks indefinitely
>> in wait_for_completion_killable_timeout() waiting for userspace to
>> supply the firmware through the sysfs interface.
>>
>> While this work item is pending, any caller of
>> __usermodehelper_disable() will deadlock attempting to acquire the
>> usermodehelper rwsem for writing, since the sysfs firmware fallback
>> path holds the rwsem for reading and is blocked waiting for userspace
>> response that can never arrive while usermode helpers are being
>> disabled.
>>
>> Observed call traces where system suspend blocked due to regulatory.db
>> async firmware request:
>>
>>   kworker/6:3 (pid 194) holding usermodehelper rwsem read lock, blocked
>>    waiting for userspace firmware response:
>>      wait_for_completion_killable_timeout+0x48
>>      firmware_fallback_sysfs+0x270
>>      _request_firmware+0x790
>>      request_firmware_work_func+0x44
>>      process_one_work[jt]+0x59c
>>      worker_thread+0x260
>>      kthread+0x150
>>      ret_from_fork+0x10
>>
>>   Caller blocked in __usermodehelper_disable() during system suspend:
>>      rwsem_down_write_slowpath+0x768
>>      down_write+0x98
>>      __usermodehelper_disable+0x3c
>>      freeze_processes+0x18
>>      pm_suspend+0x320
>>      state_store+0x104
>>      kernfs_fop_write_iter[jt]+0x168
>>      vfs_write+0x270
>>      ksys_write+0x78
>>
>> Any service or kernel subsystem invoking __usermodehelper_disable() is
>> susceptible to this hang as long as the regulatory.db sysfs fallback
>> request remains outstanding.
>>
>> Fix this by replacing the unconditional uevent-based load with a
>> two-step approach. First, attempt a synchronous load via
>> request_firmware_direct() at init time. This is fast and
>> non-blocking, if the file is present in standard paths it is loaded
>> immediately with no delay. If not found, the load is deferred to
>> wiphy_regulatory_register() and triggered via
>> firmware_request_nowait_nowarn() only when the first non-self-managed
>> wiphy registers.
>>
>> For self-managed drivers (REGULATORY_WIPHY_SELF_MANAGED), the hang is
>> avoided because wiphy_regulatory_register() handles them separately
>> and the deferred load path is never reached, so the file load is not
>> attempted at all. For this case, regulatory information is obtained
>> from driver/firmware during wiphy registration. For non-self-managed
>> drivers, the file is required and is expected to be present. The
>> deferred load via firmware_request_nowait_nowarn() is triggered only
>> when the first such wiphy registers. This ensures the database is
>> loaded only when it is actually needed, avoiding the sysfs fallback
>> path on systems where the file is absent at init time.
>>
>> Also refactor regdb_fw_cb() into two functions: regdb_load() which
>> validates and stores the firmware image, and regdb_fw_cb_restore()
>> which is the async callback that calls restore_regulatory_settings()
>> to replay all pending regulatory requests (country hints from core,
>> user, driver and country IE) that arrived while the database was not
>> yet available.
>>
>> NOTE:
>> This issue was observed on Android platforms where regulatory.db is
>> absent.
>> Steps to reproduce on Android platforms:
>>   1. Power off the device completely.
>>   2. Connect the charger; the device enters off-mode charging.
>>   3. While in off-mode charging, short press the power key.
>>
>> Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
> 
> Are you missing a `Fixes:` tag for this?
> 


I have included Fixes Tag in v2 version. Thanks.



