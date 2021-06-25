Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9288C3B43F5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhFYNCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Jun 2021 09:02:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15530 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231792AbhFYNCg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Jun 2021 09:02:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCpeF0023513;
        Fri, 25 Jun 2021 13:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=JYgEwccKC2Rr7wSU2HrwNxPlH9hWbBIyQZN2qs7DjkU=;
 b=PMNK6ayzfMolyM+/m4j0nJQweqs6VdyhhQHin2T1snre7QhQCsXbHgWaWNmQCi1pMnD0
 K8CaNOTLy93o215Ts0Wh+1glvfbJ63ROy5mEQW0XHge3RGD7Nc5U2xuF7a9RaoFFUzH/
 53Fkd0izMkHo/Dtv2O2wOVJXifajyUTY0mt2J5DfM3y3gya/XNlCmmDJMsdcfyNe5OR8
 4eKDOBHSbdpN45ntg3Blnd0W0rO7x6OoKk0pcjo6MeL7Qz1ni/+K5CSKAwHrvqUWAz3w
 +6lUgVyza6UR0SxkB8mriUhAYut1UzV0vxjnddVz2lE0p995FW69YuKaiGV5w6EWACuH qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24m1aea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:00:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PCtbDw008019;
        Fri, 25 Jun 2021 13:00:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39d243fgkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:00:13 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PD0Cn3022239;
        Fri, 25 Jun 2021 13:00:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 39d243fghn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:00:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15PD0BsR020473;
        Fri, 25 Jun 2021 13:00:11 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 06:00:11 -0700
Date:   Fri, 25 Jun 2021 16:00:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: support loading the reduced power table from
 UEFI
Message-ID: <YNXTVZVhDw3VGx2k@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: IfRGqJ1N622D0ny9RBkzuAUEhoIr3x9O
X-Proofpoint-GUID: IfRGqJ1N622D0ny9RBkzuAUEhoIr3x9O
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Luca Coelho,

The patch 9dad325f9d57: "iwlwifi: support loading the reduced power
table from UEFI" from Jun 21, 2021, leads to the following static
checker warning:

	drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load()
	error: uninitialized symbol 'len'.

drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
   256  int iwl_pnvm_load(struct iwl_trans *trans,
   257                    struct iwl_notif_wait_data *notif_wait)
   258  {
   259          u8 *data;
   260          size_t len;
                ^^^^^^^^^^

   261          struct pnvm_sku_package *package;
   262          struct iwl_notification_wait pnvm_wait;
   263          static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
   264                                                  PNVM_INIT_COMPLETE_NTFY) };
   265          int ret;
   266  
   267          /* if the SKU_ID is empty, there's nothing to do */
   268          if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
   269                  return 0;
   270  
   271          /*
   272           * If we already loaded (or tried to load) it before, we just
   273           * need to set it again.
   274           */
   275          if (trans->pnvm_loaded) {
   276                  ret = iwl_trans_set_pnvm(trans, NULL, 0);
   277                  if (ret)
   278                          return ret;
   279                  goto skip_parse;
                        ^^^^^^^^^^^^^^^

   280          }
   281  
   282          /* First attempt to get the PNVM from BIOS */
   283          package = iwl_uefi_get_pnvm(trans, &len);
   284          if (!IS_ERR_OR_NULL(package)) {
   285                  data = kmemdup(package->data, len, GFP_KERNEL);
   286  
   287                  /* free package regardless of whether kmemdup succeeded */
   288                  kfree(package);
   289  
   290                  if (data) {
   291                          /* we need only the data size */
   292                          len -= sizeof(*package);
   293                          goto parse;
   294                  }
   295          }
   296  
   297          /* If it's not available, try from the filesystem */
   298          ret = iwl_pnvm_get_from_fs(trans, &data, &len);
   299          if (ret) {
   300                  /*
   301                   * Pretend we've loaded it - at least we've tried and
   302                   * couldn't load it at all, so there's no point in
   303                   * trying again over and over.
   304                   */
   305                  trans->pnvm_loaded = true;
   306  
   307                  goto skip_parse;
   308          }
   309  
   310  parse:
   311          iwl_pnvm_parse(trans, data, len);
   312  
   313          kfree(data);
   314  
   315  skip_parse:
   316          data = NULL;
   317          /* now try to get the reduce power table, if not loaded yet */
   318          if (!trans->reduce_power_loaded) {
   319                  data = iwl_uefi_get_reduced_power(trans, &len);
   320                  if (IS_ERR_OR_NULL(data)) {
   321                          /*
   322                           * Pretend we've loaded it - at least we've tried and
   323                           * couldn't load it at all, so there's no point in
   324                           * trying again over and over.
   325                           */
   326                          trans->reduce_power_loaded = true;
   327  
   328                          goto skip_reduce_power;
   329                  }
   330          }
   331  
   332          ret = iwl_trans_set_reduce_power(trans, data, len);
                                                              ^^^
Uninitialized

   333          if (ret)
   334                  IWL_DEBUG_FW(trans,
   335                               "Failed to set reduce power table %d\n",
   336                               ret);
   337          kfree(data);
   338  
   339  skip_reduce_power:
   340          iwl_init_notification_wait(notif_wait, &pnvm_wait,
   341                                     ntf_cmds, ARRAY_SIZE(ntf_cmds),
   342                                     iwl_pnvm_complete_fn, trans);
   343  

regards,
dan carpenter
