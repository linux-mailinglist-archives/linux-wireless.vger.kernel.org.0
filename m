Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1F21618C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 00:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGFWYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 18:24:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39317 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGFWYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 18:24:47 -0400
X-Originating-IP: 45.72.255.27
Received: from TesterBox (unknown [45.72.255.27])
        (Authenticated sender: olivier.crete@ocrete.ca)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A0BDF60004;
        Mon,  6 Jul 2020 22:24:44 +0000 (UTC)
Message-ID: <ab664a0f23ca833fc531fcad61125da39328c888.camel@ocrete.ca>
Subject: rtl8812ae: high ping under load (or randomly)
From:   Olivier =?ISO-8859-1?Q?Cr=EAte?= <olivier.crete@ocrete.ca>
To:     linux-wireless@vger.kernel.org
Cc:     pkshih@realtek.com
Date:   Mon, 06 Jul 2020 18:24:42 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have a rtl 8812ae PCI desktop card and I get really poor connectivity
in Linux. In particular, I get ping times that increase a lot if I use
the connection a lot.

What I noticed by comparing with my Intel-based laptop next to it is
that iwconfig always reports a rate of 866.7Mb/s, while the rate on my
laptop fluctuates in the 100-250Mb/s range. I tried forcing the rate
with iwconfig, and it seems to help a little, but it's still not good
enough. So I suspect something is wrong with the rate control?

I've played around with the various rtlwifi module options and they
don't help.

I was suggested disable ASPM, but my motherboard doesn't seem to
support ASPM at all.

On the same computer, the card works as advertised in Windows, so I'm
pretty sure it's a driver/software issue.

I'm testing with kernel 5.6.19 and linux-firmware 20200619. And the
card is a TP-Link Archer T4E.

Please let me know how I can help debug this,

-- 
Olivier Crête
olivier.crete@ocrete.ca


