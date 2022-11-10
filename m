Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787462462D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKJPmR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 10:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiKJPmQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 10:42:16 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40B5FE7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 07:42:14 -0800 (PST)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis)
 id 1MwgKC-1pDgJo3fYI-00y6Lf; Thu, 10 Nov 2022 16:41:58 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: mt76: Fix mt7915 DBDC
Date:   Thu, 10 Nov 2022 16:39:49 +0100
Message-Id: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EXXZMaVzLRDmFLTGnDrYcnBrKZKfXqzjJ2cuEPiOF9rfWqCF6Ag
 NJoFXBpfMGpvlnKavXWqLUPtRQtUQw5gSfB7NwQFkADFHa6Jss3QGci7TkXWxtHoNhUqKV5
 MjnxbRW9ZIx5QcxRhXOmf+4DD1xPpdq6HjolPpj2AjV+/rdFUCy6y3pjmKGlaEFP61rRuwl
 GY1eeGlAD52l6cpj35fyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T60eitcUkEE=:o/M4EwKNs+JJ/tOuO9PQHM
 eXloTV7pJYMDVZUba6x05SqOsVQWRcb8H9AcDZpwxPkTuS0qhBSSPR2sMDHZ7ELg48zSb330x
 dDkhh84P0HJJcz2P+IYTC0wVuckgECGrNj1aEkxmOrndXILNKXb2V32OC7vf7QUVLEyakR09O
 BCpugfhiP/9SKu+gkbaVRcd9GRYS/saoj2RBmzcYmbgd+9qTPMz16jKvgWEov/6E17hGWgvFU
 jNQnN7un2dlDaVO2FA4P3tObY9D/fSdObJVXwh+I+Fsk2fkuKY/3JA2fXHVVYzvvZfuHRGjbr
 VkMvEJq25Yr/6twAW0dca+1M1GsiPqKca/oh0WSMc7F9SC52diz4u6yHVCIVHDa9yNxd06GIb
 Kh6YIc1MDYE3tkYWhPuhCuQYRJ9vnCTL7igxihIEE4+tU3/3Y0+q5zlIIbL1z2zTLGglsP3wv
 /KCj0kuhTMY0PgCS+V8s7F1B5DI0Blr5hIyIrCmAYzN0Z9mQns6HaAKfUTMNLf9IO4v5+vuJi
 tgZhTqC1GMnCz9Iisa0vFQ8ZM2ZJBtnWt4VAdeoLSVbZY7+AC+adFSZXHPmlf0IRRwYVRFkta
 1GfXUdwDtcK57V4bgrBKF2OAv67Zh0AKX6YMHP2VDE7u6ZcVIRDNDlQn9QqV9mET0b0/aJjZ8
 d38IJ/aElhsaBteElp0OAg5DD7pWicXJWeSb3pSFfRKwaE6cofuCLCfCFRikMvvIEwwFNZGix
 octlkPBhB3Ghmdyslz0ZXDd3LHCKMb6P2WfdG2t7HuKaLSG50sfN3OUI3m5mbP87R7HB5yCgj
 wldIXdt1rE2Jdrykk5ME0ZmoizFA5pb4jBfQX/93bQaat8VfXo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 5ghz phy capabilities were mostly broken when testing with a
mini-pcie mt7915 DBDC from AsiaRF.

I do not know about all the mt7915 variants, so I can't be sure that
this series does not break other models.

These patches are based on the mt76 tree.


