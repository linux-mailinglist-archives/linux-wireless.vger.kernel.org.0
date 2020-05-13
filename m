Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE51D1CAB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgEMR4E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 13:56:04 -0400
Received: from p-impout010aa.msg.pkvw.co.charter.net ([47.43.26.141]:51055
        "EHLO p-impout001.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMR4E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 13:56:04 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2020 13:56:04 EDT
Received: from 192.168.1.10 ([97.96.18.55])
        by cmsmtp with ESMTPA
        id YvUaj8VgKOQ8hYvV2jw2aH; Wed, 13 May 2020 17:48:57 +0000
X-Authority-Analysis: v=2.3 cv=SrXuF8G0 c=1 sm=1 tr=0
 a=gnb2rATmHlbHhomeAxXZdQ==:117 a=gnb2rATmHlbHhomeAxXZdQ==:17
 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=F25QkG8zyI3W_E7rkQAA:9 a=CjuIK1q_8ugA:10
 a=AjGcO6oz07-iQ99wixmX:22
Date:   Wed, 13 May 2020 13:48:27 -0400
From:   Marco Fonseca <marco@tampabay.rr.com>
To:     linux-wireless@vger.kernel.org
Subject: iwlwifi: 8265: unexpected LLC packets TX'ed in monitor mode
Message-ID: <20200513174827.3o7odouinuirou62@192.168.1.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4wfEAW151Ani9X9LKaYnlQ371i1xLjoMRbpc1jNkffepkWI3gBigbaTP+4S5upulBiV9eIzhCWfC8lO0K7B3j3Xj1dQGDhvkvld9L8TFNWSIEvjqUEo4kO
 f5hDY5lgoh++eBZ2arTR0HaDA9H9ALNqmGC2NwzkX0BpMVy1Rg6tuk9HWtJraVz/1YC2vSTIggMegA==
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

While in monitor mode, the 8265 will periodically transmit gratuitous
LLC packets.  In this mode, I would expect the wifi chipset to not
transmit any packets at all (unless packet injection is being used).

This behavior can be observed by a second wifi device in monitor mode.
A display filter on wireshark/tshark of 'llc' makes these easy to spot.

It seems these packets only get produced in presence of a few APs
and/or STAs but I'm not sure of the exact cause.  I don't see the LLC
packets on very quiet channels.

Other Details
-------------

wifi chipset:
  Intel(R) Dual Band Wireless AC 8265, REV=0x230

kernel:
  4.9.11 kernel

backports driver:
  iwlwifi-stack-public:release/core33:6653:327571a8

  I can use other backports versions if needed, but this was the
  version called out in:
  https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/core_release

Firmware:
36.952d9faa.0


Thank you,

Marco Fonseca

