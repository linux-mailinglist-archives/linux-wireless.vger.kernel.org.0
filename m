Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373AB35D63B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 06:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhDMEKi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 00:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhDMEKi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 00:10:38 -0400
Received: from mout1.freenet.de (mout1.freenet.de [IPv6:2001:748:100:40::2:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE06C061574
        for <linux-wireless@vger.kernel.org>; Mon, 12 Apr 2021 21:10:19 -0700 (PDT)
Received: from [195.4.92.126] (helo=sub7.freenet.de)
        by mout1.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1lWANO-0001ow-3u; Tue, 13 Apr 2021 06:10:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hbm9gsTjzfiyohpbJnuRO8X6wYngutyM5A4KsxpX7RE=; b=goKiLxNHeoCPAqhfUh8FM4FH8S
        xxju8vZg83La3f1NvgtqO362DDglatjdmXVdFVOInjPNi17YcjAAouN2N9zYjRptB8QHgKAbUWSdA
        kavMz07wPbQ7g5CIZkXdhr9GtVLdNxAT6KuyIQ5U2c/Wj5PID4cW80mlQzODh1UH4z6O2OZdrGJti
        dZYDHvx+TvTHhe5hpa9M94TigOMEq4sl0j1jj/H7gZjcTYOx/p/54kNDwF4QSgNMazS6+9JLUmTY8
        JEh9GNczYuFVMF8w+vg5ebNlqvsxV7pdZNLShA6ljLQZNE66kaQVENbeKbWJk/4JLdKQYNOaAxNTK
        K/1WaPnA==;
Received: from p200300de57147b00505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5714:7b00:5054:ff:fe15:ac42]:59456 helo=mail.maya.org)
        by sub7.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1lWANN-0005tZ-W6; Tue, 13 Apr 2021 06:10:10 +0200
Received: internal info suppressed
Subject: Re: Memory leak in rtw88-pci
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
 <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
 <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
From:   =?UTF-8?Q?Klaus_M=c3=bcller?= <kmueller@justmail.de>
Message-ID: <034ac9b5-ecc7-7b56-a447-306774cb5e54@justmail.de>
Date:   Tue, 13 Apr 2021 06:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:de:5714:7b00:5054:ff:fe15:ac42!59456
X-FNSign: v=2 s=D99D65E57264A1D1B6E748355F4F5F1C69C56DB17848C33DBFE8046C5C64D5BD
X-Scan-TS: Tue, 13 Apr 2021 06:10:10 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11.04.21 at 21:35 Larry Finger wrote:
> On 4/8/21 11:12 PM, Klaus Müller wrote:
>> May I kindly bring up this reported problem again? Is there anybody working on this problem? Or did I miss the already existing fix?
> 
> A fix has been found. The patched code is available at https://GitHub.com/lwfinger/rtw88.git. Patches are being prepared for wireless-next. From there, they will propagate into the Linux distributions.

Thanks Larry for doing QA and fixing the problem! I'm additionally very thankful for your rtw88 git repository, which provides the possibility to use actual drivers independent of the kernel version.
The actual version works fine for me.


Kind regards
Klaus
