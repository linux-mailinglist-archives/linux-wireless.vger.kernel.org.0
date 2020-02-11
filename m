Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643EA1594D5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 17:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgBKQZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 11:25:13 -0500
Received: from mr85p00im-zteg06021601.me.com ([17.58.23.187]:47749 "EHLO
        mr85p00im-zteg06021601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729000AbgBKQZN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 11:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1581438313; bh=zH3XvUf4Gwnfly5C3NsxYvl9HPUhovFyyHO7111umzE=;
        h=From:To:Subject:Date:Message-Id;
        b=OO0RlHQJ3lgyT+MHIBwjbcXObOAArjxyabjUzcbS/V1kTHfKFqoZmIVlVgpFPLD3o
         CPx3ZQ6mLQwXT1mdv0pBoHwqLEGSXIBq0w/2wgUUfmP4MYjKuWaHDP/KvOOR8xVri6
         frqXTiIpv6oXnIdbkM8EoFJaLSVoH63I2poiilqvWRH3IEAZDT1jKT+4CBhhWcZeq5
         om0QWhpIMZDhDqemtKHZBt81rsWWF43V7vJvOsqqXKRtURt3j0vCTydqVuMIKKj+n+
         9eCYtEaeOv1Ga9RcUJJzroHQ6/8Z6aUlw/tLUhBHbBrWWYL5R5v8vwNhdK6eTjQX9s
         kpvzl3b1pkBiw==
Received: from stitch.danm.net (c-73-98-236-45.hsd1.ut.comcast.net [73.98.236.45])
        by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id B31FF4010D8;
        Tue, 11 Feb 2020 16:25:12 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     dmoulding@me.com
Cc:     emmanuel.grumbach@intel.com, johannes.berg@intel.com,
        linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        luciano.coelho@intel.com
Subject: Re: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
Date:   Tue, 11 Feb 2020 09:24:50 -0700
Message-Id: <20200211162450.2493-1-dmoulding@me.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128093107.9740-1-dmoulding@me.com>
References: <20200128093107.9740-1-dmoulding@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002110119
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is just a friendly reminder that this patch has been submitted,
for what looks like a fairly major regression in iwlwifi that impacts
(as far as I can tell) *all* 3168 devices. The regression is in the
v5.5.x series and was for a while back-ported to the stable trees, but
luckily was noticed before the releases were made.

There are at least a few bug reports for this regression:

https://bugzilla.kernel.org/show_bug.cgi?id=206329
https://bugs.gentoo.org/706810
https://lkml.org/lkml/2020/2/7/811
https://bbs.archlinux.org/viewtopic.php?id=252603

The Gentoo maintainers have already applied this patch to their Linux
sources and marked their bug report "fixed". But it would be really
nice if we could get this regression fixed in the next stable v5.5.x
release.

Thanks for your attention!

-- Dan
