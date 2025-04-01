Return-Path: <linux-wireless+bounces-21008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1164A771A8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 02:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A71884618
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 00:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BA2E336B;
	Tue,  1 Apr 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GX6A6i50"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534E53AC
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465832; cv=none; b=KtinLbd+UBih97GUDWeIv2vBOrJme4v3tHAdsdsedS7Z9vw7QXQhj/4iBQJjZq/bQUsfCrbiV51/cQFP9H9/zvvLx3/ioZ4ghPvMhYbgfcqhgcMGaGqdk6N2pfnyr/xl4bDYFGSkmgcCzQaa5Dj+g6Qrmqk+d+NJFUz2GSvuJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465832; c=relaxed/simple;
	bh=cwqGr2JUrp9ldKBRfeiBnQsVQWMD2ezMlNyRYP43wFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=almJPyB/EtA3AU7XscOAscuP7+W/8l6PRokWOhWnftXa4WWvvlGuVzYL8IgBYSDZ+WBdSleZPVotlkJchaH5bXezbLAX3mrstBCqHyDUUzqHJ8ZKCaHKM4n04dBAKPnB6llwQsVuRMHjkgPNv3QiVe2KKEZxNsYDYAJbiAquJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GX6A6i50; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFCrSB032655
	for <linux-wireless@vger.kernel.org>; Tue, 1 Apr 2025 00:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4cVIN1yqYhlAiuoox7wycBo/ZgfvnsCNIE+NcE0TS80=; b=GX6A6i50xwhx/WZH
	3ruXVHt+GpN71ExJSeJMNJoS7fOIYoz3GGUe+m485hFHUFa3HBiIKIBXQx1LG/sr
	LQyxuFzWTKckFDo52E3uLfX1eYPO3Sdj7d3Zp2bz6NIOzrFuzE+/b528VAh0Wfzl
	JbSFV37KJES05TzDfyQCr6hIHxnWJEef8SzCXPxJ+Ppu3bfsDdARFMica4imbqmQ
	9f3lrVftdGTrGRnrGb5kabLXwjBazuB6SRLnRxmex3VPXcCIVbQos63o1EfkRDJ5
	N4KCEHC8L7wtyOJWdTtOg1j2o5JR15hqDOCPrsbJqpNHiRmVS+eykw/5AvJvNSjy
	Oh8SeA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qe6jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 00:03:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22406ee0243so70903125ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 17:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743465828; x=1744070628;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cVIN1yqYhlAiuoox7wycBo/ZgfvnsCNIE+NcE0TS80=;
        b=YKDGwtJnHK3Zku7FlBacNi3aEGzalSr44i7H9wgyXt/OdCnAhMUYDLpc7JRBij6JkV
         Uhk9obxOgswle5iAtrQ0FH9aaGqvNn+b4wPmuGWv2f1RLLmF4HNz/NaKn43QXsHRL+y3
         5cli3FdyF7K9p40+j4edBc+AreYdJvfPHTr+8kcXV9aEGC9gvgmujWTIsIdQxVzwur6g
         owPZm3i6d0I3RZk+dnhVX9/tLQHnKi0IUdYh5MPKq9E//SIW0anSxBq1Ft7gQTN47nop
         Vz1S8uYzJL+3EQiDOjF2zHHGyqDy8RLLvOsmTcSWn4fsEiuH7vC8Vtoh4KyZKpdi8N5r
         kUuw==
X-Gm-Message-State: AOJu0Yy9+NOu7L+x1a5EmMygXVThsRAxRHrGwqbPryXrY18xIVAqPWhh
	2uDu394q4aNdMH3TokwqpjH//srkOSWPLni2Us4wWslGafttl+rhuxB+tLCipdivBSPggrW/zIi
	DMvAz3vYVIfpOvyBXJ1+WXk5bYkeI1e1F0iPO7S3iNIXNBbjiDh6rXP4kfTMrjvKSRA==
X-Gm-Gg: ASbGncsBZth2ydH/Dxe6hzep3r+mvqcmk/IdCpcsy5ad5bMLdOkeuVcVvvUk4q7TyvV
	LezzrQJw6sF3pbo8UPhzBb1aoXK9T+5YPVUQelnIYPuRnFryzGHVJf18lMBkHPIYw+eWV8oJCNs
	BYhuioS1SI/gk7fVIibWnaWPj4RHEXKL+NjQMDNAx4T3siEcM3QFUNCmsm1RYtaOIRPIayy02nm
	SrKQA3XXyQeO33shKgfeIGy7O4a4dCFAHK9QjQ4VmPN10WdsM9TrAtqn1gZ32LKC6XZxD07xUvK
	Fyuunc/FggnYqwQJo/pYRMdD51TUMNdfGZYyCjZ0zkFMLbNYw6OwkvtUXn3PLs3PwYMrPm9htr0
	5EeGTw4fM
X-Received: by 2002:a17:902:f54a:b0:216:53fa:634f with SMTP id d9443c01a7336-2292f9ef20emr175664755ad.48.1743465827812;
        Mon, 31 Mar 2025 17:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnMu2P7tyWZHMH46/iz8oKR/XbzPFIZC5WUvTC01ExGdFd92nY5GkYQ0CBpwAML4SYY8sXxw==
X-Received: by 2002:a17:902:f54a:b0:216:53fa:634f with SMTP id d9443c01a7336-2292f9ef20emr175664275ad.48.1743465827319;
        Mon, 31 Mar 2025 17:03:47 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedc988sm76155715ad.59.2025.03.31.17.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:03:46 -0700 (PDT)
Message-ID: <64839c85-38f4-4a13-9ee1-273aed339a47@oss.qualcomm.com>
Date: Mon, 31 Mar 2025 17:03:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: Add support for link specific datapath
 stats
To: "Tamizh Chelvam Raja (QUIC)" <quic_tamizhr@quicinc.com>,
        "Balamurugan Mahalingam (QUIC)" <quic_bmahalin@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250203213237.2695131-1-quic_bmahalin@quicinc.com>
 <BL3PR02MB8163BE57AD5EF563FD8A76B383F72@BL3PR02MB8163.namprd02.prod.outlook.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <BL3PR02MB8163BE57AD5EF563FD8A76B383F72@BL3PR02MB8163.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67eb2d65 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=UjqVY_aGyNUKZPdAsKEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Tprrpjq-6WDgqLsRUR6pF3ckFq0Ty2PV
X-Proofpoint-GUID: Tprrpjq-6WDgqLsRUR6pF3ckFq0Ty2PV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=901 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310164

On 2/4/2025 10:37 PM, Tamizh Chelvam Raja (QUIC) wrote:
...
>> +static int ath12k_open_link_stats(struct inode *inode, struct file
>> +*file) {
>> +       struct ath12k_vif *ahvif = inode->i_private;
>> +       size_t len = 0, buf_len = (PAGE_SIZE * 2);
>> +       struct ath12k_link_stats linkstat;
>> +       struct ath12k_link_vif *arvif;
>> +       unsigned long links_map;
>> +       struct wiphy *wiphy;
>> +       int link_id, i;
>> +       char *buf;
>> +
>> +       if (!ahvif)
>> +               return -EINVAL;
>> +
>> +       buf = kzalloc(buf_len, GFP_KERNEL);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       wiphy = ahvif->ah->hw->wiphy;
>> +       wiphy_lock(wiphy);
>> +
>> +       links_map = ahvif->links_map;
>> +       for_each_set_bit(link_id, &links_map,
>> +                        IEEE80211_MLD_MAX_NUM_LINKS) {
>> +               arvif = rcu_dereference_protected(ahvif->link[link_id],
>> +
>> + lockdep_is_held(&wiphy->mtx));
>> +
> 
> Here arvif can be NULL, so it would be good to check before using it.
> 
>> +               spin_lock_bh(&arvif->link_stats_lock);
>> +               linkstat = arvif->link_stats;
>> +               spin_unlock_bh(&arvif->link_stats_lock);
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "link[%d] Tx Unicast Frames Enqueued  = %d\n",
>> +                                link_id, linkstat.tx_enqueued);
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "link[%d] Tx Broadcast Frames Enqueued = %d\n",
>> +                                link_id, linkstat.tx_bcast_mcast);
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "link[%d] Tx Frames Completed = %d\n",
>> +                                link_id, linkstat.tx_completed);
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "link[%d] Tx Frames Dropped = %d\n",
>> +                                link_id, linkstat.tx_dropped);
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "link[%d] Tx Frame descriptor Encap Type = ",
>> +                                link_id);
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                        " raw:%d",
>> +                                        linkstat.tx_encap_type[0]);
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                        " native_wifi:%d",
>> +                                        linkstat.tx_encap_type[1]);
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                        " ethernet:%d",
>> +                                        linkstat.tx_encap_type[2]);
> 
> Like encrypt type stats below this also can be put it in a loop.
> 
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "\nlink[%d] Tx Frame descriptor Encrypt Type = ",
>> +                                link_id);
>> +
>> +               for (i = 0; i < HAL_ENCRYPT_TYPE_MAX; i++) {
>> +                       len += scnprintf(buf + len, buf_len - len,
>> +                                        " %d:%d", i,
>> +                                        linkstat.tx_encrypt_type[i]);
>> +               }
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                                "\nlink[%d] Tx Frame descriptor Type = buffer:%d
>> extension:%d\n",
>> +                                link_id, linkstat.tx_desc_type[0],
>> +                                linkstat.tx_desc_type[1]);
>> +
>> +               len += scnprintf(buf + len, buf_len - len,
>> +                               "------------------------------------------------------\n");
>> +       }
>> +
>> +       wiphy_unlock(wiphy);
>> +
>> +       file->private_data = buf;
>> +
>> +       return 0;
>> +}

Hi Maha,

I didn't see any response to the two feedback comments given.

I'd like to clear this patch from my backlog, so either need a response why
the feedback isn't applicable or need a v5 which incorporates the feedback.

Thanks!
/jeff

