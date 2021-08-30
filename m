Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A23FB15A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhH3Gr6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 02:47:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44455 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhH3Gr6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 02:47:58 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17U6kwLT3030735, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17U6kwLT3030735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 14:46:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 30 Aug 2021 14:46:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Aug 2021 14:46:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098]) by
 RTEXMBS04.realtek.com.tw ([fe80::cdd5:82a3:e854:7098%5]) with mapi id
 15.01.2106.013; Mon, 30 Aug 2021 14:46:57 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>, Kevin Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH 3/4] rtw88: support adaptivity for ETSI/JP DFS region
Thread-Topic: [PATCH 3/4] rtw88: support adaptivity for ETSI/JP DFS region
Thread-Index: AQHXnMqu0PGj5vBD7k685h/O45/eP6uLmpVA
Date:   Mon, 30 Aug 2021 06:46:57 +0000
Message-ID: <61a242c186bf453d80820d81e1c48464@realtek.com>
References: <20210802063140.25670-1-pkshih@realtek.com>
        <20210802063140.25670-4-pkshih@realtek.com> <87ilzo4gyr.fsf@codeaurora.org>
In-Reply-To: <87ilzo4gyr.fsf@codeaurora.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/8/30_=3F=3F_04:21:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/30/2021 06:26:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165837 [Aug 30 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 457 457 f9912fc467375383fbac52a53ade5bbe1c769e2a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2021 06:30:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kvalo=codeaurora.org@mg.codeaurora.org [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> Behalf Of Kalle Valo
> Sent: Sunday, August 29, 2021 7:40 PM
> To: Pkshih
> Cc: tony0620emma@gmail.com; linux-wireless@vger.kernel.org; Timlee; Kevin Yang
> Subject: Re: [PATCH 3/4] rtw88: support adaptivity for ETSI/JP DFS region
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > Add Energy Detected CCA (EDCCA) mechanism to detect energy on the channel.
> > And EDCCA support adaptivity mode now. From MIC Ordinance Regulating Radio
> > Equipment article 49.20, ETSI EN-300-328 and EN-301-893, the device should
> > be able to dynamically pause TX activity when energy detected on the air.
> > According to ETSI/JP DFS region, driver will set corresponding threshold
> > and stop TX activity if the detected energy exceeds the threshold. For now,
> > we support it on 8822b and 8822c first.
> >
> > By default, EDCCA mechanism is turned on. For ETSI/JP DFS region, it will
> > turn to adaptivity mode. However, with adaptivity, if environment is too
> > nosiy, TX may often be halted. So, a debugfs for EDCCA is added. It can
> > show what EDCCA mode is used currently. And EDCCA mechanism can be turned
> > on/off through the debugfs while debugging.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
> > +static ssize_t rtw_debugfs_set_edcca_enable(struct file *filp,
> > +					    const char __user *buffer,
> > +					    size_t count, loff_t *loff)
> > +{
> > +	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
> > +	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
> > +	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
> > +	bool input;
> > +	int err;
> > +
> > +	err = kstrtobool_from_user(buffer, count, &input);
> > +	if (err)
> > +		return err;
> > +
> > +	rtw_edcca_enabled = input;
> > +	rtw_phy_adaptivity_set_mode(rtwdev);
> > +
> > +	return count;
> > +}
> > +
> > +static int rtw_debugfs_get_edcca_enable(struct seq_file *m, void *v)
> > +{
> > +	struct rtw_debugfs_priv *debugfs_priv = m->private;
> > +	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
> > +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> > +
> > +	seq_printf(m, "EDCCA %s: EDCCA mode %d\n",
> > +		   rtw_edcca_enabled ? "enabled" : "disabled",
> > +		   dm_info->edcca_mode);
> > +	return 0;
> > +}
> 
> [...]
> 
> > --- a/drivers/net/wireless/realtek/rtw88/main.c
> > +++ b/drivers/net/wireless/realtek/rtw88/main.c
> > @@ -23,6 +23,7 @@ EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
> >  bool rtw_bf_support = true;
> >  unsigned int rtw_debug_mask;
> >  EXPORT_SYMBOL(rtw_debug_mask);
> > +bool rtw_edcca_enabled = true;
> 
> You are making rtw_edcca_enabled per driver, should it instead be per
> device? If something is changed via debugfs the assumption is that the
> value is per device.
> 
> For example, let's say you have two rtw88 devices attached on the same
> system, device A and B. If a user changes edcca via debugfs on device A
> it will also change the state in device B. Is that the desired
> functionality? If yes, I think you should add a comment to
> rtw_edcca_enabled explaining that.
> 

As mentioned in commit message, the debugfs is expected to be used when debugging
in noisy environment. In that case, we think all rtw88 devices will probably
be affected. Besides, we believe that turning EDCCA off is a temporary state under
debugging.

Based on the two points, it seems no need to maintain rtw_edcca_enabled by device,
so a comment will be added to explain this.

--
Ping-Ke

