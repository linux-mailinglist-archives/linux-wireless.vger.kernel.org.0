Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAD28009D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgJAN7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 09:59:41 -0400
Received: from pop36.abv.bg ([194.153.145.227]:59578 "EHLO pop36.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbgJAN7k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 09:59:40 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop36.abv.bg (Postfix) with ESMTP id 7807B18052AE;
        Thu,  1 Oct 2020 16:59:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1601560774; bh=+zImgXO6wVCewzurwjE3evEcT/e+cxgjf2RYMw+RLcA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=xB9aJtXiO9v/DMPt5ZL3bsLnXg6uhI7PmEwrh5XY5iNYqcYv0aRxZVC60L0u37Sqn
         uSAMf4WcL5tqLIoGfDzBwPfWZLYBvEdaD8lJv9SQUeAIRQm46xqBhVwMECUcM62L45
         HgrqBBOs+fLj8eEiKCIRvGJ29Px38BadNNXude8g=
X-HELO: [192.168.192.3]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=gvalkov@abv.bg
Received: from Unknown (HELO [192.168.192.3]) (87.118.177.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Thu, 01 Oct 2020 16:59:34 +0300
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] mac80211: fix regression in sta connection monitor
From:   Georgi Valkov <gvalkov@abv.bg>
In-Reply-To: <099b1679-87c4-1ac5-978b-a1110db93f54@nbd.name>
Date:   Thu, 1 Oct 2020 16:59:30 +0300
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        openwrt-devel@lists.openwrt.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F798A1A-4CBA-47E9-9F2A-E407EDEBCD90@abv.bg>
References: <20200921154545.91971-1-nbd@nbd.name>
 <7A099B27-5278-4D2A-91A1-6B795CB0E221@abv.bg>
 <099b1679-87c4-1ac5-978b-a1110db93f54@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix!

I can confirm that the original regression is now fully resolved in v3 =
of your patch.
Further testing showed that the second issue: group key handshake failed =
(RSN) after 4 tries is unrelated. Apparently OpenWRT does not support =
group rekeying when WDS is used, so it always fails and should be =
disabled: option wpa_group_rekey =E2=80=980=E2=80=99.

Please excuse me for taking your time with the unrelated issue. There =
was no way for me to know that, since the disconnect remained, and it =
may take up to 24 hours to detect.

Thank you for your help!
Georgi

> On 2020-09-22, at 11:56 AM, Felix Fietkau <nbd@nbd.name> wrote:
>=20
> On 2020-09-22 09:28, Georgi Valkov wrote:
>> Hi Felix!
>>=20
>> In the original code before the regression, as well as in the fix I
>> proposed, probe_send_count was always reset if ack is true, while in
>> your fix it will not be reset when non-null frames are received. The
>> connection failed again after 10 hours and the STA remained offline =
for
>> two minutes instead of two seconds. I should also note that I spent
>> multiple days testing the fix I proposed and I had no disconnects.
>> Please revise your fix again!
> Thanks for the info. Handling non-null frames in that function is
> incomplete, because it does not cover the 802.3 tx status path.
> I'll make v2 patch that checks the timestamp of the last ACK in
> ieee80211_sta_work instead.
>=20
> - Felix
>=20

