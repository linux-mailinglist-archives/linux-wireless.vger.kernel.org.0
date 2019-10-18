Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96547DBDE2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 08:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504400AbfJRGxv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 02:53:51 -0400
Received: from jake.logic.tuwien.ac.at ([128.130.175.117]:41378 "EHLO
        jake.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504372AbfJRGxv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 02:53:51 -0400
Received: from burischnitzel.preining.info (om126208246007.22.openmobile.ne.jp [126.208.246.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by jake.logic.tuwien.ac.at (Postfix) with ESMTPSA id 064E5C03F7;
        Fri, 18 Oct 2019 08:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=logic.at; s=dkim;
        t=1571381625; bh=yXPJe8f9/EMHqnWtnxOaRN7s6KZqxS+PLBVMczjpsx0=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Subject:From;
        b=ZOa2bWnsiOX4TxQi3PJ+tnloy0lnRZnCOl5Ul5O60Y7NduMsHeHUnFd35wsT1QLCS
         CQ+6sDU55Qondd/VTH9Nn+M+AOis/F1ehPWn1Ca8/oU3Z1LsmnSnAvPUT0m2ta1lcN
         nQb9ePsFiKZoUlt1c79RBENYYV61hNF7NDvc4yZo=
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id ACF2F6D268DA; Fri, 18 Oct 2019 15:53:39 +0900 (JST)
Received: from orsmga101.jf.intel.com ([10.7.208.22])
  by orsmga001-1.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 23:43:06 -0700
Received-SPF: None (mtab.intel.com: no sender authenticity
  information available from domain of preining@logic.at)
  identity=pra; client-ip=128.130.175.117;
  receiver=mtab.intel.com; envelope-from="preining@logic.at";
  x-sender="preining@logic.at"; x-conformance=sidf_compatible
Received-SPF: Pass (mtab.intel.com: domain of preining@logic.at
  designates 128.130.175.117 as permitted sender)
  identity=mailfrom; client-ip=128.130.175.117;
  receiver=mtab.intel.com; envelope-from="preining@logic.at";
  x-sender="preining@logic.at"; x-conformance=sidf_compatible;
  x-record-type="v=spf1"
Received-SPF: None (mtab.intel.com: no sender authenticity
  information available from domain of
  postmaster@jake.logic.tuwien.ac.at) identity=helo;
  client-ip=128.130.175.117; receiver=mtab.intel.com;
  envelope-from="preining@logic.at";
  x-sender="postmaster@jake.logic.tuwien.ac.at";
  x-conformance=sidf_compatible
Authentication-Results: mtab.intel.com; spf=None smtp.pra=preining@logic.at; spf=Pass smtp.mailfrom=preining@logic.at; spf=None smtp.helo=postmaster@jake.logic.tuwien.ac.at; dkim=pass (signature verified) header.i=@logic.at; dmarc=pass (p=none dis=none) d=logic.at
IronPort-PHdr: =?us-ascii?q?9a23=3ALpZP4RQJKelxoul1Es6dQl8KDtpsv+yvbD5Q0YIu?=
 =?us-ascii?q?jvd0So/mwa6yZxGN2/xhgRfzUJnB7Loc0qyK6vumBjxLsMnJmUtBWaQEbwUCh8?=
 =?us-ascii?q?QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6?=
 =?us-ascii?q?OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Tu8QVjodvLqQ8wQbVr3VVfO?=
 =?us-ascii?q?hb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPHw768PttRnY?=
 =?us-ascii?q?UAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD+v4btnRAPuhS?=
 =?us-ascii?q?waMTMy7WPZhdFqjK9DrhyvpwJxzZPXbo6aKPVxY63ScMgGRWZdQspdSzBND5mi?=
 =?us-ascii?q?Y4YJEuEPPfxYr474p1YWtRW+AhOsC/jxxT9Smn/9wLc00/4/HgHH2gwgHtQOsH?=
 =?us-ascii?q?vJp9jyLKcSS/66zKjOzTXCafNW1izw6IzPchAuoPGDQah8ftDNyUQ2EQ7Ok1ue?=
 =?us-ascii?q?qYvgPzyP1+QNtXCW7/J6Ve2xim4nrQBxoj6gxss2i4nJgIwVylfC+C5kw4g1Pc?=
 =?us-ascii?q?W1RFNlbdOnCpdcqi+XO5dsTs8/QWxluDw2xqAbtZO5ZCQHyYkrywTCZ/GDcIWE?=
 =?us-ascii?q?+BHuWeaLLTtlmn5pZLSyjAuo/0e60O3zTMy03U5KriVbltnMsWgA1x7J5ciEVP?=
 =?us-ascii?q?Rx5EOh2TGA1wDS9u5IO1w0lbfVKp4g3LEwkIAfvl7fESPsgkr2kLeadkQi+ue2?=
 =?us-ascii?q?9+TqeqjqqoGfOoNulw3zPLgiltaiDek6MgUCRXWX9fm+2bH7+E32WrRKjvk4kq?=
 =?us-ascii?q?nDt5DaINwWprajAwBL04Yj7Re/DzGp0NkDmXkHK11FeBObgITzIV7OPOj0De2j?=
 =?us-ascii?q?jFS0jDdr2/fGM6XgApXJIHnOi7Phfbd7605Bxws/19Ff55RICr4fJPL/QFP+tN?=
 =?us-ascii?q?vdDkxxDwvhx+fhFcU4yYIEVGaCGbSxLqzfqxmL6/gpLu3KY5Ua/H75Kv4497vt?=
 =?us-ascii?q?gGU/lFs1Y6akx90UZWq+E/AgJF+WJTLthsgpFWYMoxp4Ter2hVnEWjlWNFioWK?=
 =?us-ascii?q?dpwDYhAo+8Ec/7XI2shr2H02/vBodbZ2ZHDF+kFXDndo7CUutaO3HaGdNojjFR?=
 =?us-ascii?q?DevpcIQmzxz77FanmYoiFfLd/2gjjbym1NVx4LeOxxM79jEyC8OS0mrLU3xrn2?=
 =?us-ascii?q?4OATY9mqlj8xQkmwWzlJNgivkdLuR9ovZAUwM0L5nZlrQoD9f9WwmHd8vbEQ/6?=
 =?us-ascii?q?EOXjOik4S5cK+/FLe1x0Qo3wihfM3iHsCqNHz7E=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BFAACiXaldl3WvgoBkHAEBAQEBBwEBE?=
 =?us-ascii?q?QEEBAEBgWkFAQELAYMLVDIqjSiYCYFOh0oUgWcJAQEBAQEBAQEBCB8QAQGHSRw?=
 =?us-ascii?q?HAQQyBw4CDAEBAQMBAQECAQIDBAETAQEBAQEIFgaFXQyCOiKDMAYBARMSEzsTI?=
 =?us-ascii?q?R0dARSDNAGCdgEFsXKCfQEBBYc7CYE0AYo6gWuBf4VlgwiGJJZ2lmCBRmeCMow?=
 =?us-ascii?q?OhlgngjuHUYN3i0eKYoNQmWiBWQmCAU04gycJRxAUgVAJAwwCCYIHhCKICTIzk?=
 =?us-ascii?q?XwBAQ?=
X-IPAS-Result: =?us-ascii?q?A0BFAACiXaldl3WvgoBkHAEBAQEBBwEBEQEEBAEBgWkFAQE?=
 =?us-ascii?q?LAYMLVDIqjSiYCYFOh0oUgWcJAQEBAQEBAQEBCB8QAQGHSRwHAQQyBw4CDAEBA?=
 =?us-ascii?q?QMBAQECAQIDBAETAQEBAQEIFgaFXQyCOiKDMAYBARMSEzsTIR0dARSDNAGCdgE?=
 =?us-ascii?q?FsXKCfQEBBYc7CYE0AYo6gWuBf4VlgwiGJJZ2lmCBRmeCMowOhlgngjuHUYN3i?=
 =?us-ascii?q?0eKYoNQmWiBWQmCAU04gycJRxAUgVAJAwwCCYIHhCKICTIzkXwBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,310,1566889200"; 
   d="scan'208";a="90706374"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from jake.logic.tuwien.ac.at ([128.130.175.117])
  by mtab.intel.com with ESMTP; 17 Oct 2019 23:43:03 -0700
Received: from burischnitzel.preining.info (a-fhn3-09120.noc.ntt-west.nsk.ne.jp [61.198.85.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by jake.logic.tuwien.ac.at (Postfix) with ESMTPSA id ADB87C03F7;
        Fri, 18 Oct 2019 08:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=logic.at; s=dkim;
        t=1571380979; bh=yXPJe8f9/EMHqnWtnxOaRN7s6KZqxS+PLBVMczjpsx0=;
        h=Date:From:To:Subject:From;
        b=S+Cri1OtrooI4HCtVJndn0MgvSFGd5kPOYw9HcBC4ZVrSg25uZ/+O6KP6H4ik8mqx
         JOnDpnjXQ3nryp3eJcbptOZZxEXWxp8kxGrQ6HmetP6QmaQp1/4gKOTnu7gVmEqeTT
         Tq5wBZWMhzCYKHV69j4I0JrJ84yrvIg2/wYN52DU=
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id EEEF66D2658A; Fri, 18 Oct 2019 15:30:22 +0900 (JST)
Date:   Fri, 18 Oct 2019 15:30:22 +0900
From:   Norbert Preining <preining@logic.at>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilw@linux.intel.com
Subject: IWL AC 8260, suspect GRP implementation, broken connectivity
Message-ID: <20191018063022.6bqunomkyqabgljc@burischnitzel.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear all,

(please cc)

linux 5.3.N (currently .7), but also older kernels
Debian/sid
Thinkpad X260
iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
iwlwifi 0000:04:00.0: loaded firmware version 36.8fd77bb3.0 op_mode iwlmvm

In one particular location I see completely broken connection: dns does
not work (resolve does not work), ping, ssh breaks down, http breaks
down, it really sounds like a really weak connection.

The problem is that:
- the *same* laptop booted into Windows works at high speed connections
- other computers (2 Mac) around here work without problems
- mobile also connects without any problem

There are no RX/TX errors whatsoever. I tried reducing MTU, to no
effect. The only warning I see is
	TCP: wlp4s0: Driver has suspect GRO implementation, TCP performance may be compromised.


wlp4s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1400
        inet 172.17.1.166  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::fddc:f32e:f9cb:fded  prefixlen 64  scopeid 0x20<link>
        ether e4:a7:a0:66:6d:f4  txqueuelen 1000  (Ethernet)
        RX packets 11164  bytes 7459009 (7.1 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 13204  bytes 3062515 (2.9 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

I am a bit at loss how to debug this, or better, whether it is possible
to get back normal connectivity?

Thanks a lot for any pointer

Norbert

--
PREINING Norbert                               http://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
