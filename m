Return-Path: <linux-wireless+bounces-32307-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCWpBC2PomlT4AQAu9opvQ
	(envelope-from <linux-wireless+bounces-32307-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 07:46:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D6D1C0A10
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 07:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEEA3052B8F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254846BF;
	Sat, 28 Feb 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pHNZtAuF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aQGFkpZx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E1368961
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261162; cv=none; b=SkQHTMIBam58K6p8j430Un8mtQI69TEioi8Pv8PPMaJeV7n/DmJ2FrRGvv/xTY1zOPXVGGsXxuSidxN7JsiS2gnPV8eNoU0x52FcTNpsfT+34swjbSy5ETqZ1mOU2orgjx6ZmS86oA69fclm5UQrapJnguAypUP4l+qynDNjzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261162; c=relaxed/simple;
	bh=qEMxdEMOARNsBacT6QqisXGjH8etp3ZybmT7HOwUXL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kGD6oNYeXJhzI+86PdqSCQoCZBADaCeI3TXonvrm7sN1EWyukwNrLJIHmL783zvQd4VaG4hI4qMdmhTO6NCLy3TW5CYbDXwHjg0r3hs44JS3hYG9vMTwbMMSY18R7PjWv+GWq675Q4oJoBilD2P02cX1gXMmG/5I3TauXJ89uC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pHNZtAuF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aQGFkpZx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S6WExi3590506
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8RbkQ5UqROlPfy0kuLZRi9PuNAFFOkh4/L3WTN7RXAA=; b=pHNZtAuFaxe6f4UY
	nQ11RtYcEq0ZxJiJKHtdUEjd5ELyKuxnCe4KGzW09c1hQbBEG8J+7mjXd1VFoyTU
	RoYQOlc+uAAs/IfDIh+18Z/fv+823lm19T6KDkTapVBWz26hlEn55diB+Ls2g/Za
	NO2kLmbcH4cdmxEUtoAHx5YZ4icJKx87PlkCLbKwp4BTQaYxs/L2CyP2py2RLx+w
	RofBQEIv+2k73H27oBjyOuXELrwvTAyGfVNPnZ4qcORfXN2VbfOGYfTEvRSjua3l
	GGouGShzsDp9XwnNnWosmGaj36F/N2bSuBGUPbiuA6UYTFlCsnCMMKNbIUPJIKZ4
	kNXYIg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6gabx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:45:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e1dab2235so1464976a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 22:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772261159; x=1772865959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RbkQ5UqROlPfy0kuLZRi9PuNAFFOkh4/L3WTN7RXAA=;
        b=aQGFkpZxVvzoIutTJQmb7W7Nzfgv9vtTqG7XSM1oZTvBpUFSR+2TAXdhKbwJ+JU28B
         A+ZuKBlYm4FkHLff2pA5/rfa0A1q1xUj8Ra1tWGlvCBHTRDPpIeV5PmnGcsJw8t2GuPz
         JORsOgIoD6z2swlSSIaDbWQFC6k3cLmguIl5rmx+GWhFzUAU78nWs1sbqnnIhpwUW34h
         BizUxExRJQ0d7/XisckAc3CkpwIf5cQZVJDn6u+R5GSmUPeWs0ezp6EfLrJHe2vJOFQD
         aFsdl5qXQ/mO09NL4NxpiZGWn0nnBWvCxh8tAM/k+uzwYaW9nIJl9L9nlQcYvUx/aEEB
         4sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772261159; x=1772865959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RbkQ5UqROlPfy0kuLZRi9PuNAFFOkh4/L3WTN7RXAA=;
        b=fhbYfTXsmfxlKKah578TqycbVFJPZ+OIVSRxIKyz6mPWtgWMey3vveatmpCtTjoRj4
         cKbRIHvy32OWlSjPqHHUFmwrklmpL3vaCBAoytdKv1W2u/6ZJdfQD46ROd+dJwXYzJuN
         9cpCO2b6rsWz/DnPlT1M6g1UG6+ln+oogFth7ALv15emdsxrqQ8FjwhqTwzuDvg4ssYJ
         +62jmiFaqYIaRQQKcdNWxhe7h7marQH7SdR3z7aSihB/bUriAFyAji1DwTkdZBrvk0h0
         g5dhd1ruIjUbEA6+r4hYdRoXAGDuElvjga/1P9W5eHWGSs+DQAF017NwID5PRUDsFZDh
         u7pA==
X-Forwarded-Encrypted: i=1; AJvYcCXnMZnec2LBgLMJ065zW4QzAAi0eaWR1HRCrmfeGTcL7Vp94Ve96Pt2sTdy0mDtKgcEyKvo7H6GsTtLabdElA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYuvwskWbxrcoIki9T+T78nPJIr78WNR7WSzdNRtZXCr9tD+m
	n6nNBaw967braNIVE3p33vqM3dMSy9J9HmXxOXfVYDyruvLYWHYcE1eks+bmI0TCMN2oN5vD+pt
	2udBRKAntNbaoyqIbllhjcZptK+CqePfI9FCMHM3+ZNKJ2kpScqtRn+4umj9QgskJ2XRS03Z7zW
	fkdQ==
X-Gm-Gg: ATEYQzySWubb6X17Xo6kf8pb8ItZp/CWMh+m8sGTWBQwMm+gZ+daK2X22s/NjdRiMRB
	Hkc5zelUYWO8mEBxMKOn/yitf959XhMDEs3aff+5c/94jz5EojjVXeRpPYajUFctbxy8xE9FcBh
	5EKyXrsmcELf1d5b5cLw8k1lK8GjilToFoJfj1lavRT6/lR3dTgYkmGXCOR6Vi3RNogYQHCbmRw
	HfuGhzcyMsjQv5UMpg3m3FBAp+yepk6FmBAL6MC/UMjtLNPpHPerWTP8KYKRq+SeJpBat73bHlt
	VhkQpjSlAtpaPT+NOrWLWt7KdsLOMHHQMRh97g5+32jcokUpB8T5wUrkWjMOuPZM28xv23uuFG9
	mU4Aw93M4WQ4R9OrwkbYIiiU+6AmjCqDoNTqsT1BMi/c/NfmhkdTHVTS/hJ8k04O1DYE=
X-Received: by 2002:a05:6a00:14c9:b0:81f:993e:ecf6 with SMTP id d2e1a72fcca58-8274d9e974amr5485992b3a.33.1772261158757;
        Fri, 27 Feb 2026 22:45:58 -0800 (PST)
X-Received: by 2002:a05:6a00:14c9:b0:81f:993e:ecf6 with SMTP id d2e1a72fcca58-8274d9e974amr5485986b3a.33.1772261158277;
        Fri, 27 Feb 2026 22:45:58 -0800 (PST)
Received: from [192.168.82.30] ([157.51.81.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a029b13sm7242792b3a.50.2026.02.27.22.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 22:45:57 -0800 (PST)
Message-ID: <0e276fba-7a1a-4d2f-a3da-1f3ad53a8a56@oss.qualcomm.com>
Date: Sat, 28 Feb 2026 12:15:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maybe problem with ieee80211_tear_down_links return value.
To: Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <40a9eca2-17fb-b839-e31f-eb4aecb2ca41@candelatech.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <40a9eca2-17fb-b839-e31f-eb4aecb2ca41@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uLIKoVmu0A3vPb123rWuRyL3d2zq3tnR
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a28f27 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=246QjU3JZtZKFnheHnOONg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=oixyeaKaRUQcOqBbnnIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDA1OCBTYWx0ZWRfX4CNLVwsE329y
 bJlOTQDwkGEh4v0Fc5X9D+PXXT/yhZlntAD8mdSo2O3dCHtk+WtZUVG9U2A/MbJqbCr84EZvhl3
 99/6KVls6iu8FvIYdzQESDDWiw0SdZMADHx7UTauj/YzV9g3hlFEzIdICx2OBjn8kbUThD/+MM6
 gTuizsTJ1YsrKxxdYuhJcp0/y/yeYcoHSHpdyWWn/KlE3iZADlNR55geYt9BkmmFALJJLhu7fHN
 E8lSYvFhRPI0Q6Nk7Q2D8PT09j08Eg2pkrHH+u+dOvh+jqF7m3bjvQqIL6zBSvnTMnMYWDwixCP
 fhERFa6WJQDUVo4cYb4KSU3V8CST9kzfxf8BS3NN0qGvTBjI/05FI9DANVcGrXXU4bNYm1PCYM/
 RC7EbcNu6zuKw4vRiIsDTFfEbannTU+xD0Abw5fvmBCkNRcmm4CWs4Vh0/Zz1pr5WcP9CmbAPj+
 DBwKMhONR/S1JPOH2Ow==
X-Proofpoint-GUID: uLIKoVmu0A3vPb123rWuRyL3d2zq3tnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602280058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32307-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62D6D1C0A10
X-Rspamd-Action: no action



On 2/28/2026 6:28 AM, Ben Greear wrote:
> While checking on some other problems, I ended up adding logging to the 
> code path
> below from net/mac80211/link.c.  This path is hit very often on my 
> system, and if I understand
> the code correctly, it should only hit in error cases where MLO links 
> have duplicated
> MAC addresses.
> 
>      ret = ieee80211_check_dup_link_addrs(sdata);
>      if (!ret) {
>          /* for keys we will not be able to undo this */
>          ieee80211_tear_down_links(sdata, to_free, rem);
> 
> The ieee80211_check_dup_link_addrs method appears to return 0 when there 
> are no duplicates,
> and -EALREADY when there are duplicates.  So maybe the check above 
> should be reversed to be:
> 
> if (ret) {
> ??
> 


The ieee80211_check_dup_link_addrs() helper returns 0 when no duplicates 
are found and -EALREADY on duplicates, as you described.

However, in the caller the pattern:

         if (!ret) {
                 /* for keys we will not be able to undo this */
                 ieee80211_tear_down_links(sdata, to_free, rem);

                 ieee80211_set_vif_links_bitmaps(sdata, new_links, 
dormant_links);

                 /* tell the driver */
                 if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
                         ret = drv_change_vif_links(sdata->local, sdata,
                                                    old_links & old_active,
                                                    new_links & 
sdata->vif.active_links,
                                                    old);
                 if (!new_links)
                         ieee80211_debugfs_recreate_netdev(sdata, false);

                 if (sdata->vif.type == NL80211_IFTYPE_AP)
                         ieee80211_update_apvlan_links(sdata);
         }

treats ret == 0 as the success/commit path (i.e., only proceed with 
tearing down removed links, updating link bitmaps, and notifying the 
driver after validating the new link configuration)


So I don’t think the condition should be reversed. If it were changed to 
if (ret), we’d end up committing the update only when duplicates are 
detected (-EALREADY), which seems backwards given the current flow (and 
the later rollback handling when ret is non-zero).

--
Ramesh


