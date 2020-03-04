Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9417942B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgCDP6V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 10:58:21 -0500
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:49377 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbgCDP6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 10:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1583337501; bh=U1LicW9J5m3kLAsdYt/c0Nx23UgAJ8vfKFRwIjtKWts=;
        h=From:To:Subject:Date:Message-Id;
        b=DHLTnD2e392iuirv2SP9zShUSAZqCy3iJRVCgH17A9oDnQd3zUUdtdPSKWn1uat0+
         DIWEJtP7paXu8S1PkS3/H84uBWXNJofOKL7QZWXrynal5Vboc4KaPUpvwVidKl/4xS
         /y4jrqRjSFNYBQXqjNvynP5Q9fQtGSBf35W0NOmu7D7E2WO4xUsm3wwN/80aqYBlz/
         pWa2BvHLkr8bB6TZY+jcxdagCTzRXN7D8PbH5Gof9KKh/Z3hlgghLHZTfUz1jUBKMM
         fGefTdejsaJFYGcaNu22k02ow+L5Dya/F7fGi/q1aGXmUtumf7YJKSwH1QMrI3qKww
         dxq5HXVxwBZ2g==
Received: from stitch.danm.net (c-73-98-236-45.hsd1.ut.comcast.net [73.98.236.45])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 961A92A08DA;
        Wed,  4 Mar 2020 15:58:20 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     luciano.coelho@intel.com
Cc:     dmoulding@me.com, emmanuel.grumbach@intel.com,
        johannes.berg@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, linuxwifi@intel.com
Subject: Re: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
Date:   Wed,  4 Mar 2020 08:58:10 -0700
Message-Id: <20200304155810.9108-1-dmoulding@me.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <b80b1af73554cb9d76d9814be40c61265c283cbf.camel@intel.com>
References: <b80b1af73554cb9d76d9814be40c61265c283cbf.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=648 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003040118
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On March 4, 2020 at 2:06 AM, Luciano Coelho <luciano.coelho@intel.com>
wrote:

> I guess this should be sent to stable v5.5 as well. Dan, would you
> like to do that?

Yes, sure I will do that. The regression was briefly discussed[1] on
the stable list as it was almost backported to the older trees (5.4.x,
etc). Greg K-H requested that I ping the stable list once the patch
lands in Linus's tree. So I've been keeping an eye on it, waiting for
the merges to happen. Let me know if there is something else I should
be doing to expedite the process if you think that's needed.

-- Dan

[1] https://lore.kernel.org/stable/20200205093102.GB1164405@kroah.com/
