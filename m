Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71258459C6E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhKWGzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 01:55:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:36951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhKWGzf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 01:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637650330;
        bh=D5V9g9Q2kV1q2sYqTY8Pkx19avIpNQBHWhSveo2yESk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Wb1dLs9IJK5LiOF3rBarOT2myRt0vPM07h/geClbSBf5p5eDGGEKyLcfxuYJzH+1a
         dyaCfkhuptazM388e+FNTulcnpjkg0nh72aVn/+7QESz1GUGaHHKY+5rOuV9FQ6hr9
         cTx/kWT5WNpx41XPkRw2dECiLhwvv5ti9cq/zC3Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.76.170] ([80.245.76.170]) by web-mail.gmx.net
 (3c-app-gmx-bs49.server.lan [172.19.170.102]) (via HTTP); Tue, 23 Nov 2021
 07:52:10 +0100
MIME-Version: 1.0
Message-ID: <trinity-9127d749-a767-4f0c-9502-7916fd39e393-1637650330226@3c-app-gmx-bs49>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Xing Song <xing.song@mediatek.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Xing Song <xing.song@mediatek.com>
Subject: Aw: [PATCH] mac80211: set up the fwd_skb->dev for mesh forwarding
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 Nov 2021 07:52:10 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20211123033123.2684-1-xing.song@mediatek.com>
References: <20211123033123.2684-1-xing.song@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/44f5pypWWgTR5lrcbOK89wKkxZF9V9AyJY0cGhbPwSSA+1LO9eY0iZIBMoBcNUxySE/N
 71sk/bhVXLXNXVDLTtrYlkC9fvOjOCHd08eQyix9shM4gB0xp1RyisLgDxCJoatTR1oDHXlpKs2G
 d5gpm0pqHumS9YpTN68WO1Jzd6md9IXj9P6hpqJfl221JkzYYxxtV6oSPGNij1+62xeWrCCET4cV
 d23Zkk5/S5+GdJHizPfZ6MDtXA5p1YTZi9kbhD+76EPnhRAe4uH4w6m+R+0iphsmuvkhvpTejYHU
 ro=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fy5vRU5rtEg=:ouXey/6r6NLcjSMkEVKBST
 rgnEGV1feE+SzqWsfSE5qAEIcjBNcHZPieS5Uf/dRGzEfoSs+uLjt0nQJUGqe0L16ZinvHSSZ
 jUIrJIwT5QiCOxw3Klacggy6jbrGdvje2rIurpduSKTmCdEE5ZJlwrQNQfk35Ekl4nlzApiFg
 8iVwljHTNeRPNMiO08j5cAMq78dk8+NNpxwbyzsD0OtDuc3iZ1zcMYUxMHBBCr2ls6rd1wqxr
 Zrpf1z+NGOjFPuhXlxWHFkt6A8TNCwvTfRrvoyv0pN173hdnpQ438i3p1T35dmFFB2bRCxD0Q
 0b4kvJ3CZlrCWShiJTiNzDsyFtu5KqxnGHf+XDb3WI4WpVIfWgl3fzZF4oXGDA2NEr5mhdIWj
 UWprMyQcsfYb13u/d3UFnHn24wVpqYuNGEThlrXFOt8EYBqGx/fc8BbHy9l715zDRqNgAfHsy
 +gv+/WhI1tR4cEq5ubFVA/rx3c6YLJt6MiPZrJoxwtL72Mm+rMFKaOT9RdQU9Zw+pvXwtQuMU
 6AU8tJffdmEmE5NUUMMdteLz6oVJ0v+DGHBi/C7rwveTDHaSmRhX4yHtfQx0dBbH/f8b8CLfb
 PVbzYhDUcK8WR3RGpx3p5Nj/s1inNqxJPxC4A2uqDFPzsCoBSJJBVjFXRyZLUvkjlgwf+38J3
 g2yD2oh1qQlMPwb0lGvmlcf+Xd6RUNINDp9oPRHz9gE6hVV3Ou1VvRArao+6qBByswb/Pjs5A
 ro9Qd+kbOvEUWkjzfweZDmLTAoYlSwoJMo9arCJPliNk8evRq2Z+SNNVh5SKZzC7y/wzPIebN
 mJOBFs+
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thank you for the Patch, it fixes the issue i've reported here [1]

Tested-By: Frank Wunderlich <frank-w@public-files.de>

regards Frank

[1] https://www.spinics.net/lists/linux-wireless/msg216928.html
