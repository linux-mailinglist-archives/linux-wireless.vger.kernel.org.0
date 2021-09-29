Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E938D41C21A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 11:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbhI2J5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Sep 2021 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbhI2J5q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Sep 2021 05:57:46 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F8C06161C
        for <linux-wireless@vger.kernel.org>; Wed, 29 Sep 2021 02:56:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 24so2265489oix.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Sep 2021 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZzrlEW/fIONHDL4eTGWAwdhO5+LgpEugLfpPd6AdvFY=;
        b=eEq942c8tKWmUB8D8hu3yj+8TktDl7Fyisl/O8MnlEhBOUo3NbMp6kQfdL3IWS1tGK
         lL/1K3NGaroy824kjFWj/WND0CJ9SGkLkCvYfIYA6GyA8QDFmvilYhKlJ2sOL2GcQXRi
         pheAiszUacf5cjNbaJYEosKpFMvVdWxvaFtotZuap1UmlSL3x4Arwcgd2hKKzdQdYpI/
         NGdErgkd4TgqqIrfRmlxzqnYVt8r9MwZyiNVuIkMQEUEuS5O+PXk0eFVYO403ooEnv5W
         YWD/PBxtDN3A7dzSRce7vCi+oQCO1ofnML5Ua0pXpv+mSRLkx+XmBTrv4TX1UUoduKcq
         LHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZzrlEW/fIONHDL4eTGWAwdhO5+LgpEugLfpPd6AdvFY=;
        b=JlwgbLYNp5RWnAPbnB6V/ogh4/Wd4+2bjpk8nNAnCFjyMyLyh4xZjOUeK6D7dk5YG5
         KRy2LQMnLqzzWknfJbmIu8rFZAY1K5M6xGzDH93gJdTsaaxxwVacYqrWtuVvAu/GOjnm
         xv5SG+Oohf6+Bqs3IGs16FiS3p0luvP2qrrkE+3SwQAgLj8H3HhWSlm8VLcz09B0Q40o
         hOu+0eL1FqCbbL4lV440Al88/7gMJI5eMPOswrir1HC3L14FMZ84YLCMGhCRAVPW1TDR
         eg4GM8x+f5kvHYyNHWSPORChTZghDkNFJFQTho+Td3yZVu0HKVTyLPj8XP9lAxpgaL+F
         i5mw==
X-Gm-Message-State: AOAM532mbsD0QME3IE1biA+uv1SWwORweBNyZzNJU7anqQh9GSQ+eXo7
        dkQQ93g4zoD/EZFxvrPqubj42nKj3UBP7LugI57rjvb0qMtEPtTlKZxvOQ==
X-Google-Smtp-Source: ABdhPJxGqcVUO8gArUiviUkbjqMLuWPN3OMeH94NA0bn9wiybe0D7MfeETfX6cwFqSvAhxuGkJE9BxKWCBjfp9ShpdI=
X-Received: by 2002:a54:4389:: with SMTP id u9mr7195195oiv.132.1632909365359;
 Wed, 29 Sep 2021 02:56:05 -0700 (PDT)
MIME-Version: 1.0
From:   Will Yang <willyangywt@gmail.com>
Date:   Wed, 29 Sep 2021 17:55:54 +0800
Message-ID: <CAKCvHdezdR29EXKS3eZMde3VgTEWMoxV5mc6gxZsCMhhbZhNZw@mail.gmail.com>
Subject: rtw8822ce: support for miracast?
To:     tony0620emma@gmail.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000acb97c05cd1f5605"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000acb97c05cd1f5605
Content-Type: text/plain; charset="UTF-8"

(I am really sorry for the duplication of emails, it's just I keep
rejected by the linux-wireless mailing list because of outlook and
HTML email)
Hi tony-emma,

I am using a fedora linux 34 with a RTL8822CE, and this network
controller is hardware capable of running miracast (aka wifi p2p), but
it doesn't seems to have driver support for it.

Is the support for miracast already in the kernel driver? If not, can
it be added?

Thank you!

`iw phy`
Wiphy phy0
Supported interface modes:
 * IBSS
 * managed
 * AP
 * AP/VLAN
 * monitor
 * mesh point

Attached output of `sudo lspci -vv` and `iw phy`

--000000000000acb97c05cd1f5605
Content-Type: text/plain; charset="US-ASCII"; name="lspcivv.txt"
Content-Disposition: attachment; filename="lspcivv.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ku5c2amw0>
X-Attachment-Id: f_ku5c2amw0

IyBzdWRvIGxzcGNpIC12dgowMTowMC4wIE5ldHdvcmsgY29udHJvbGxlcjogUmVhbHRlayBTZW1p
Y29uZHVjdG9yIENvLiwgTHRkLiBSVEw4ODIyQ0UgODAyLjExYWMgUENJZSBXaXJlbGVzcyBOZXR3
b3JrIEFkYXB0ZXIKCVN1YnN5c3RlbTogTGVub3ZvIERldmljZSBjMTIzCglDb250cm9sOiBJL08r
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0g
PlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBieXRl
cwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDc5CglJT01NVSBncm91cDogNwoJUmVn
aW9uIDA6IEkvTyBwb3J0cyBhdCAyMDAwIFtzaXplPTI1Nl0KCVJlZ2lvbiAyOiBNZW1vcnkgYXQg
ZmQ2MDAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NjRLXQoJQ2FwYWJpbGl0
aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJ
LSBEMSsgRDIrIEF1eEN1cnJlbnQ9Mzc1bUEgUE1FKEQwKyxEMSssRDIrLEQzaG90KyxEM2NvbGQr
KQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1F
LQoJQ2FwYWJpbGl0aWVzOiBbNTBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0
Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAwZmVlMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGll
czogWzcwXSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9h
ZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8NHVzLCBMMSA8NjR1cwoJCQlF
eHRUYWctIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0LSBTbG90UG93ZXJM
aW1pdCAwLjAwMFcKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5z
dXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJ
CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURldlN0YToJQ29y
ckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyKyBUcmFuc1BlbmQt
CgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MSwgQVNQTSBMMHMgTDEs
IEV4aXQgTGF0ZW5jeSBMMHMgPDR1cywgTDEgPDY0dXMKCQkJQ2xvY2tQTSsgU3VycHJpc2UtIExM
QWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXArCgkJTG5rQ3RsOglBU1BNIEwxIEVuYWJsZWQ7IFJD
QiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNKyBBdXRX
aWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MgKG9rKSwgV2lk
dGggeDEgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFC
V01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1l
b3V0RGlzKyBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JG
RiBWaWEgbWVzc2FnZS9XQUtFIywgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBv
d2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0K
CQkJIEZSUy0gVFBIQ29tcC0gRXh0VFBIQ29tcC0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0
Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUw
bXMsIFRpbWVvdXREaXMtIExUUi0gT0JGRiBEaXNhYmxlZCwKCQkJIEF0b21pY09wc0N0bDogUmVx
RW4tCgkJTG5rQ2FwMjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjVHVC9zLCBDcm9zc2xpbmst
IFJldGltZXItIDJSZXRpbWVycy0gRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAy
LjVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBO
b3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5j
ZVNPUy0KCQkJIENvbXBsaWFuY2UgRGUtZW1waGFzaXM6IC02ZEIKCQlMbmtTdGEyOiBDdXJyZW50
IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1YWxpemF0
aW9uUGhhc2UxLQoJCQkgRXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFzZTMtIExp
bmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtS
ZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFsxMDAgdjJdIEFkdmFuY2VkIEVycm9yIFJl
cG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQt
IFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlVRU1z
azoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhP
Ri0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVTdnJ0OglETFArIFNERVMr
IFRMUC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GKyBNYWxmVExQKyBF
Q1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlDRVN0YToJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0g
Um9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyLQoJCUNFTXNrOglSeEVyci0gQmFkVExQ
LSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2FwOglG
aXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBFQ1JDQ2hrQ2Fw
KyBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4UHJlcy0g
SGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAKCUNhcGFiaWxpdGllczogWzE0OCB2MV0gRGV2aWNlIFNlcmlhbCBOdW1iZXIgMDAtZTAtNGMt
ZmYtZmUtYzgtMjItMDEKCUNhcGFiaWxpdGllczogWzE1OCB2MV0gTGF0ZW5jeSBUb2xlcmFuY2Ug
UmVwb3J0aW5nCgkJTWF4IHNub29wIGxhdGVuY3k6IDBucwoJCU1heCBubyBzbm9vcCBsYXRlbmN5
OiAwbnMKCUNhcGFiaWxpdGllczogWzE2MCB2MV0gTDEgUE0gU3Vic3RhdGVzCgkJTDFTdWJDYXA6
IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BNX0wxLjErIEwxX1BNX1N1
YnN0YXRlcysKCQkJICBQb3J0Q29tbW9uTW9kZVJlc3RvcmVUaW1lPTMwdXMgUG9ydFRQb3dlck9u
VGltZT02MHVzCgkJTDFTdWJDdGwxOiBQQ0ktUE1fTDEuMi0gUENJLVBNX0wxLjErIEFTUE1fTDEu
Mi0gQVNQTV9MMS4xKwoJCQkgICBUX0NvbW1vbk1vZGU9MHVzIExUUjEuMl9UaHJlc2hvbGQ9MTYz
ODQwbnMKCQlMMVN1YkN0bDI6IFRfUHdyT249MTUwdXMKCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBy
dHdfODgyMmNlCglLZXJuZWwgbW9kdWxlczogcnR3ODhfODgyMmNlCgo+IGl3IHBoeQpXaXBoeSBw
aHkwCgl3aXBoeSBpbmRleDogMAoJbWF4ICMgc2NhbiBTU0lEczogNAoJbWF4IHNjYW4gSUVzIGxl
bmd0aDogMjI0MyBieXRlcwoJbWF4ICMgc2NoZWQgc2NhbiBTU0lEczogNAoJbWF4ICMgbWF0Y2gg
c2V0czogMAoJUmV0cnkgc2hvcnQgbGltaXQ6IDcKCVJldHJ5IGxvbmcgbGltaXQ6IDQKCUNvdmVy
YWdlIGNsYXNzOiAwICh1cCB0byAwbSkKCURldmljZSBzdXBwb3J0cyBULURMUy4KCVN1cHBvcnRl
ZCBDaXBoZXJzOgoJCSogV0VQNDAgKDAwLTBmLWFjOjEpCgkJKiBXRVAxMDQgKDAwLTBmLWFjOjUp
CgkJKiBUS0lQICgwMC0wZi1hYzoyKQoJCSogQ0NNUC0xMjggKDAwLTBmLWFjOjQpCgkJKiBDQ01Q
LTI1NiAoMDAtMGYtYWM6MTApCgkJKiBHQ01QLTEyOCAoMDAtMGYtYWM6OCkKCQkqIEdDTVAtMjU2
ICgwMC0wZi1hYzo5KQoJCSogQ01BQyAoMDAtMGYtYWM6NikKCQkqIENNQUMtMjU2ICgwMC0wZi1h
YzoxMykKCQkqIEdNQUMtMTI4ICgwMC0wZi1hYzoxMSkKCQkqIEdNQUMtMjU2ICgwMC0wZi1hYzox
MikKCg==
--000000000000acb97c05cd1f5605
Content-Type: text/plain; charset="US-ASCII"; name="iw-phy.txt"
Content-Disposition: attachment; filename="iw-phy.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ku5c2cuq1>
X-Attachment-Id: f_ku5c2cuq1

IyBpdyBwaHkKV2lwaHkgcGh5MAoJd2lwaHkgaW5kZXg6IDAKCW1heCAjIHNjYW4gU1NJRHM6IDQK
CW1heCBzY2FuIElFcyBsZW5ndGg6IDIyNDMgYnl0ZXMKCW1heCAjIHNjaGVkIHNjYW4gU1NJRHM6
IDQKCW1heCAjIG1hdGNoIHNldHM6IDAKCVJldHJ5IHNob3J0IGxpbWl0OiA3CglSZXRyeSBsb25n
IGxpbWl0OiA0CglDb3ZlcmFnZSBjbGFzczogMCAodXAgdG8gMG0pCglEZXZpY2Ugc3VwcG9ydHMg
VC1ETFMuCglTdXBwb3J0ZWQgQ2lwaGVyczoKCQkqIFdFUDQwICgwMC0wZi1hYzoxKQoJCSogV0VQ
MTA0ICgwMC0wZi1hYzo1KQoJCSogVEtJUCAoMDAtMGYtYWM6MikKCQkqIENDTVAtMTI4ICgwMC0w
Zi1hYzo0KQoJCSogQ0NNUC0yNTYgKDAwLTBmLWFjOjEwKQoJCSogR0NNUC0xMjggKDAwLTBmLWFj
OjgpCgkJKiBHQ01QLTI1NiAoMDAtMGYtYWM6OSkKCQkqIENNQUMgKDAwLTBmLWFjOjYpCgkJKiBD
TUFDLTI1NiAoMDAtMGYtYWM6MTMpCgkJKiBHTUFDLTEyOCAoMDAtMGYtYWM6MTEpCgkJKiBHTUFD
LTI1NiAoMDAtMGYtYWM6MTIpCglBdmFpbGFibGUgQW50ZW5uYXM6IFRYIDB4MyBSWCAweDMKCUNv
bmZpZ3VyZWQgQW50ZW5uYXM6IFRYIDB4MyBSWCAweDMKCVN1cHBvcnRlZCBpbnRlcmZhY2UgbW9k
ZXM6CgkJICogSUJTUwoJCSAqIG1hbmFnZWQKCQkgKiBBUAoJCSAqIEFQL1ZMQU4KCQkgKiBtb25p
dG9yCgkJICogbWVzaCBwb2ludAoJQmFuZCAxOgoJCUNhcGFiaWxpdGllczogMHgxOTZmCgkJCVJY
IExEUEMKCQkJSFQyMC9IVDQwCgkJCVNNIFBvd2VyIFNhdmUgZGlzYWJsZWQKCQkJUlggSFQyMCBT
R0kKCQkJUlggSFQ0MCBTR0kKCQkJUlggU1RCQyAxLXN0cmVhbQoJCQlNYXggQU1TRFUgbGVuZ3Ro
OiA3OTM1IGJ5dGVzCgkJCURTU1MvQ0NLIEhUNDAKCQlNYXhpbXVtIFJYIEFNUERVIGxlbmd0aCA2
NTUzNSBieXRlcyAoZXhwb25lbnQ6IDB4MDAzKQoJCU1pbmltdW0gUlggQU1QRFUgdGltZSBzcGFj
aW5nOiAxNiB1c2VjICgweDA3KQoJCUhUIE1heCBSWCBkYXRhIHJhdGU6IDMwMCBNYnBzCgkJSFQg
VFgvUlggTUNTIHJhdGUgaW5kZXhlcyBzdXBwb3J0ZWQ6IDAtMTUsIDMyCgkJQml0cmF0ZXMgKG5v
bi1IVCk6CgkJCSogMS4wIE1icHMKCQkJKiAyLjAgTWJwcwoJCQkqIDUuNSBNYnBzCgkJCSogMTEu
MCBNYnBzCgkJCSogNi4wIE1icHMKCQkJKiA5LjAgTWJwcwoJCQkqIDEyLjAgTWJwcwoJCQkqIDE4
LjAgTWJwcwoJCQkqIDI0LjAgTWJwcwoJCQkqIDM2LjAgTWJwcwoJCQkqIDQ4LjAgTWJwcwoJCQkq
IDU0LjAgTWJwcwoJCUZyZXF1ZW5jaWVzOgoJCQkqIDI0MTIgTUh6IFsxXSAoMjAuMCBkQm0pCgkJ
CSogMjQxNyBNSHogWzJdICgyMC4wIGRCbSkKCQkJKiAyNDIyIE1IeiBbM10gKDIwLjAgZEJtKQoJ
CQkqIDI0MjcgTUh6IFs0XSAoMjAuMCBkQm0pCgkJCSogMjQzMiBNSHogWzVdICgyMC4wIGRCbSkK
CQkJKiAyNDM3IE1IeiBbNl0gKDIwLjAgZEJtKQoJCQkqIDI0NDIgTUh6IFs3XSAoMjAuMCBkQm0p
CgkJCSogMjQ0NyBNSHogWzhdICgyMC4wIGRCbSkKCQkJKiAyNDUyIE1IeiBbOV0gKDIwLjAgZEJt
KQoJCQkqIDI0NTcgTUh6IFsxMF0gKDIwLjAgZEJtKQoJCQkqIDI0NjIgTUh6IFsxMV0gKDIwLjAg
ZEJtKQoJCQkqIDI0NjcgTUh6IFsxMl0gKDIwLjAgZEJtKQoJCQkqIDI0NzIgTUh6IFsxM10gKDIw
LjAgZEJtKQoJCQkqIDI0ODQgTUh6IFsxNF0gKGRpc2FibGVkKQoJQmFuZCAyOgoJCUNhcGFiaWxp
dGllczogMHgxOTZmCgkJCVJYIExEUEMKCQkJSFQyMC9IVDQwCgkJCVNNIFBvd2VyIFNhdmUgZGlz
YWJsZWQKCQkJUlggSFQyMCBTR0kKCQkJUlggSFQ0MCBTR0kKCQkJUlggU1RCQyAxLXN0cmVhbQoJ
CQlNYXggQU1TRFUgbGVuZ3RoOiA3OTM1IGJ5dGVzCgkJCURTU1MvQ0NLIEhUNDAKCQlNYXhpbXVt
IFJYIEFNUERVIGxlbmd0aCA2NTUzNSBieXRlcyAoZXhwb25lbnQ6IDB4MDAzKQoJCU1pbmltdW0g
UlggQU1QRFUgdGltZSBzcGFjaW5nOiAxNiB1c2VjICgweDA3KQoJCUhUIE1heCBSWCBkYXRhIHJh
dGU6IDMwMCBNYnBzCgkJSFQgVFgvUlggTUNTIHJhdGUgaW5kZXhlcyBzdXBwb3J0ZWQ6IDAtMTUs
IDMyCgkJVkhUIENhcGFiaWxpdGllcyAoMHgwM2QwNzFiMik6CgkJCU1heCBNUERVIGxlbmd0aDog
MTE0NTQKCQkJU3VwcG9ydGVkIENoYW5uZWwgV2lkdGg6IG5laXRoZXIgMTYwIG5vciA4MCs4MAoJ
CQlSWCBMRFBDCgkJCXNob3J0IEdJICg4MCBNSHopCgkJCVRYIFNUQkMKCQkJU1UgQmVhbWZvcm1l
ZQoJCQlNVSBCZWFtZm9ybWVlCgkJCStIVEMtVkhUCgkJVkhUIFJYIE1DUyBzZXQ6CgkJCTEgc3Ry
ZWFtczogTUNTIDAtOQoJCQkyIHN0cmVhbXM6IE1DUyAwLTkKCQkJMyBzdHJlYW1zOiBub3Qgc3Vw
cG9ydGVkCgkJCTQgc3RyZWFtczogbm90IHN1cHBvcnRlZAoJCQk1IHN0cmVhbXM6IG5vdCBzdXBw
b3J0ZWQKCQkJNiBzdHJlYW1zOiBub3Qgc3VwcG9ydGVkCgkJCTcgc3RyZWFtczogbm90IHN1cHBv
cnRlZAoJCQk4IHN0cmVhbXM6IG5vdCBzdXBwb3J0ZWQKCQlWSFQgUlggaGlnaGVzdCBzdXBwb3J0
ZWQ6IDc4MCBNYnBzCgkJVkhUIFRYIE1DUyBzZXQ6CgkJCTEgc3RyZWFtczogTUNTIDAtOQoJCQky
IHN0cmVhbXM6IE1DUyAwLTkKCQkJMyBzdHJlYW1zOiBub3Qgc3VwcG9ydGVkCgkJCTQgc3RyZWFt
czogbm90IHN1cHBvcnRlZAoJCQk1IHN0cmVhbXM6IG5vdCBzdXBwb3J0ZWQKCQkJNiBzdHJlYW1z
OiBub3Qgc3VwcG9ydGVkCgkJCTcgc3RyZWFtczogbm90IHN1cHBvcnRlZAoJCQk4IHN0cmVhbXM6
IG5vdCBzdXBwb3J0ZWQKCQlWSFQgVFggaGlnaGVzdCBzdXBwb3J0ZWQ6IDc4MCBNYnBzCgkJQml0
cmF0ZXMgKG5vbi1IVCk6CgkJCSogNi4wIE1icHMKCQkJKiA5LjAgTWJwcwoJCQkqIDEyLjAgTWJw
cwoJCQkqIDE4LjAgTWJwcwoJCQkqIDI0LjAgTWJwcwoJCQkqIDM2LjAgTWJwcwoJCQkqIDQ4LjAg
TWJwcwoJCQkqIDU0LjAgTWJwcwoJCUZyZXF1ZW5jaWVzOgoJCQkqIDUxODAgTUh6IFszNl0gKDIz
LjAgZEJtKQoJCQkqIDUyMDAgTUh6IFs0MF0gKDIzLjAgZEJtKQoJCQkqIDUyMjAgTUh6IFs0NF0g
KDIzLjAgZEJtKQoJCQkqIDUyNDAgTUh6IFs0OF0gKDIzLjAgZEJtKQoJCQkqIDUyNjAgTUh6IFs1
Ml0gKDIzLjAgZEJtKSAocmFkYXIgZGV0ZWN0aW9uKQoJCQkqIDUyODAgTUh6IFs1Nl0gKDIzLjAg
ZEJtKSAocmFkYXIgZGV0ZWN0aW9uKQoJCQkqIDUzMDAgTUh6IFs2MF0gKDIzLjAgZEJtKSAocmFk
YXIgZGV0ZWN0aW9uKQoJCQkqIDUzMjAgTUh6IFs2NF0gKDIzLjAgZEJtKSAocmFkYXIgZGV0ZWN0
aW9uKQoJCQkqIDU1MDAgTUh6IFsxMDBdIChkaXNhYmxlZCkKCQkJKiA1NTIwIE1IeiBbMTA0XSAo
ZGlzYWJsZWQpCgkJCSogNTU0MCBNSHogWzEwOF0gKGRpc2FibGVkKQoJCQkqIDU1NjAgTUh6IFsx
MTJdIChkaXNhYmxlZCkKCQkJKiA1NTgwIE1IeiBbMTE2XSAoZGlzYWJsZWQpCgkJCSogNTYwMCBN
SHogWzEyMF0gKGRpc2FibGVkKQoJCQkqIDU2MjAgTUh6IFsxMjRdIChkaXNhYmxlZCkKCQkJKiA1
NjQwIE1IeiBbMTI4XSAoZGlzYWJsZWQpCgkJCSogNTY2MCBNSHogWzEzMl0gKGRpc2FibGVkKQoJ
CQkqIDU2ODAgTUh6IFsxMzZdIChkaXNhYmxlZCkKCQkJKiA1NzAwIE1IeiBbMTQwXSAoZGlzYWJs
ZWQpCgkJCSogNTcyMCBNSHogWzE0NF0gKGRpc2FibGVkKQoJCQkqIDU3NDUgTUh6IFsxNDldICgz
MC4wIGRCbSkKCQkJKiA1NzY1IE1IeiBbMTUzXSAoMzAuMCBkQm0pCgkJCSogNTc4NSBNSHogWzE1
N10gKDMwLjAgZEJtKQoJCQkqIDU4MDUgTUh6IFsxNjFdICgzMC4wIGRCbSkKCQkJKiA1ODI1IE1I
eiBbMTY1XSAoMzAuMCBkQm0pCglTdXBwb3J0ZWQgY29tbWFuZHM6CgkJICogbmV3X2ludGVyZmFj
ZQoJCSAqIHNldF9pbnRlcmZhY2UKCQkgKiBuZXdfa2V5CgkJICogc3RhcnRfYXAKCQkgKiBuZXdf
c3RhdGlvbgoJCSAqIG5ld19tcGF0aAoJCSAqIHNldF9tZXNoX2NvbmZpZwoJCSAqIHNldF9ic3MK
CQkgKiBhdXRoZW50aWNhdGUKCQkgKiBhc3NvY2lhdGUKCQkgKiBkZWF1dGhlbnRpY2F0ZQoJCSAq
IGRpc2Fzc29jaWF0ZQoJCSAqIGpvaW5faWJzcwoJCSAqIGpvaW5fbWVzaAoJCSAqIHJlbWFpbl9v
bl9jaGFubmVsCgkJICogc2V0X3R4X2JpdHJhdGVfbWFzawoJCSAqIGZyYW1lCgkJICogZnJhbWVf
d2FpdF9jYW5jZWwKCQkgKiBzZXRfd2lwaHlfbmV0bnMKCQkgKiBzZXRfY2hhbm5lbAoJCSAqIHRk
bHNfbWdtdAoJCSAqIHRkbHNfb3BlcgoJCSAqIHByb2JlX2NsaWVudAoJCSAqIHNldF9ub2Fja19t
YXAKCQkgKiByZWdpc3Rlcl9iZWFjb25zCgkJICogc3RhcnRfcDJwX2RldmljZQoJCSAqIHNldF9t
Y2FzdF9yYXRlCgkJICogY29ubmVjdAoJCSAqIGRpc2Nvbm5lY3QKCQkgKiBzZXRfcW9zX21hcAoJ
CSAqIHNldF9tdWx0aWNhc3RfdG9fdW5pY2FzdAoJV29XTEFOIHN1cHBvcnQ6CgkJICogd2FrZSB1
cCBvbiBkaXNjb25uZWN0CgkJICogd2FrZSB1cCBvbiBtYWdpYyBwYWNrZXQKCQkgKiB3YWtlIHVw
IG9uIHBhdHRlcm4gbWF0Y2gsIHVwIHRvIDEyIHBhdHRlcm5zIG9mIDEtMTI4IGJ5dGVzLAoJCSAg
IG1heGltdW0gcGFja2V0IG9mZnNldCAwIGJ5dGVzCgkJICogY2FuIGRvIEdUSyByZWtleWluZwoJ
CSAqIHdha2UgdXAgb24gR1RLIHJla2V5IGZhaWx1cmUKCQkgKiB3YWtlIHVwIG9uIG5ldHdvcmsg
ZGV0ZWN0aW9uLCB1cCB0byA0IG1hdGNoIHNldHMKCXNvZnR3YXJlIGludGVyZmFjZSBtb2RlcyAo
Y2FuIGFsd2F5cyBiZSBhZGRlZCk6CgkJICogQVAvVkxBTgoJCSAqIG1vbml0b3IKCWludGVyZmFj
ZSBjb21iaW5hdGlvbnMgYXJlIG5vdCBzdXBwb3J0ZWQKCUhUIENhcGFiaWxpdHkgb3ZlcnJpZGVz
OgoJCSAqIE1DUzogZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYKCQkgKiBtYXhpbXVtIEEt
TVNEVSBsZW5ndGgKCQkgKiBzdXBwb3J0ZWQgY2hhbm5lbCB3aWR0aAoJCSAqIHNob3J0IEdJIGZv
ciA0MCBNSHoKCQkgKiBtYXggQS1NUERVIGxlbmd0aCBleHBvbmVudAoJCSAqIG1pbiBNUERVIHN0
YXJ0IHNwYWNpbmcKCURldmljZSBzdXBwb3J0cyBUWCBzdGF0dXMgc29ja2V0IG9wdGlvbi4KCURl
dmljZSBzdXBwb3J0cyBIVC1JQlNTLgoJRGV2aWNlIHN1cHBvcnRzIFNBRSB3aXRoIEFVVEhFTlRJ
Q0FURSBjb21tYW5kCglEZXZpY2Ugc3VwcG9ydHMgbG93IHByaW9yaXR5IHNjYW4uCglEZXZpY2Ug
c3VwcG9ydHMgc2NhbiBmbHVzaC4KCURldmljZSBzdXBwb3J0cyBBUCBzY2FuLgoJRGV2aWNlIHN1
cHBvcnRzIHBlci12aWYgVFggcG93ZXIgc2V0dGluZwoJRHJpdmVyIHN1cHBvcnRzIGZ1bGwgc3Rh
dGUgdHJhbnNpdGlvbnMgZm9yIEFQL0dPIGNsaWVudHMKCURyaXZlciBzdXBwb3J0cyBhIHVzZXJz
cGFjZSBNUE0KCURldmljZSBzdXBwb3J0cyBjb25maWd1cmluZyB2ZGV2IE1BQy1hZGRyIG9uIGNy
ZWF0ZS4KCURldmljZSBzdXBwb3J0cyByYW5kb21pemluZyBNQUMtYWRkciBpbiBzY2Fucy4KCW1h
eCAjIHNjYW4gcGxhbnM6IDEKCW1heCBzY2FuIHBsYW4gaW50ZXJ2YWw6IC0xCgltYXggc2NhbiBw
bGFuIGl0ZXJhdGlvbnM6IDAKCVN1cHBvcnRlZCBUWCBmcmFtZSB0eXBlczoKCQkgKiBJQlNTOiAw
eDAwIDB4MTAgMHgyMCAweDMwIDB4NDAgMHg1MCAweDYwIDB4NzAgMHg4MCAweDkwIDB4YTAgMHhi
MCAweGMwIDB4ZDAgMHhlMCAweGYwCgkJICogbWFuYWdlZDogMHgwMCAweDEwIDB4MjAgMHgzMCAw
eDQwIDB4NTAgMHg2MCAweDcwIDB4ODAgMHg5MCAweGEwIDB4YjAgMHhjMCAweGQwIDB4ZTAgMHhm
MAoJCSAqIEFQOiAweDAwIDB4MTAgMHgyMCAweDMwIDB4NDAgMHg1MCAweDYwIDB4NzAgMHg4MCAw
eDkwIDB4YTAgMHhiMCAweGMwIDB4ZDAgMHhlMCAweGYwCgkJICogQVAvVkxBTjogMHgwMCAweDEw
IDB4MjAgMHgzMCAweDQwIDB4NTAgMHg2MCAweDcwIDB4ODAgMHg5MCAweGEwIDB4YjAgMHhjMCAw
eGQwIDB4ZTAgMHhmMAoJCSAqIG1lc2ggcG9pbnQ6IDB4MDAgMHgxMCAweDIwIDB4MzAgMHg0MCAw
eDUwIDB4NjAgMHg3MCAweDgwIDB4OTAgMHhhMCAweGIwIDB4YzAgMHhkMCAweGUwIDB4ZjAKCQkg
KiBQMlAtY2xpZW50OiAweDAwIDB4MTAgMHgyMCAweDMwIDB4NDAgMHg1MCAweDYwIDB4NzAgMHg4
MCAweDkwIDB4YTAgMHhiMCAweGMwIDB4ZDAgMHhlMCAweGYwCgkJICogUDJQLUdPOiAweDAwIDB4
MTAgMHgyMCAweDMwIDB4NDAgMHg1MCAweDYwIDB4NzAgMHg4MCAweDkwIDB4YTAgMHhiMCAweGMw
IDB4ZDAgMHhlMCAweGYwCgkJICogUDJQLWRldmljZTogMHgwMCAweDEwIDB4MjAgMHgzMCAweDQw
IDB4NTAgMHg2MCAweDcwIDB4ODAgMHg5MCAweGEwIDB4YjAgMHhjMCAweGQwIDB4ZTAgMHhmMAoJ
U3VwcG9ydGVkIFJYIGZyYW1lIHR5cGVzOgoJCSAqIElCU1M6IDB4NDAgMHhiMCAweGMwIDB4ZDAK
CQkgKiBtYW5hZ2VkOiAweDQwIDB4YjAgMHhkMAoJCSAqIEFQOiAweDAwIDB4MjAgMHg0MCAweGEw
IDB4YjAgMHhjMCAweGQwCgkJICogQVAvVkxBTjogMHgwMCAweDIwIDB4NDAgMHhhMCAweGIwIDB4
YzAgMHhkMAoJCSAqIG1lc2ggcG9pbnQ6IDB4YjAgMHhjMCAweGQwCgkJICogUDJQLWNsaWVudDog
MHg0MCAweGQwCgkJICogUDJQLUdPOiAweDAwIDB4MjAgMHg0MCAweGEwIDB4YjAgMHhjMCAweGQw
CgkJICogUDJQLWRldmljZTogMHg0MCAweGQwCglTdXBwb3J0ZWQgZXh0ZW5kZWQgZmVhdHVyZXM6
CgkJKiBbIFJSTSBdOiBSUk0KCQkqIFsgRklMU19TVEEgXTogU1RBIEZJTFMgKEZhc3QgSW5pdGlh
bCBMaW5rIFNldHVwKQoJCSogWyBDT05UUk9MX1BPUlRfT1ZFUl9OTDgwMjExIF06IGNvbnRyb2wg
cG9ydCBvdmVyIG5sODAyMTEKCQkqIFsgVFhRUyBdOiBGUS1Db0RlbC1lbmFibGVkIGludGVybWVk
aWF0ZSBUWFFzCgkJKiBbIFNDQU5fUkFORE9NX1NOIF06IHVzZSByYW5kb20gc2VxdWVuY2UgbnVt
YmVycyBpbiBzY2FucwoJCSogWyBTQ0FOX01JTl9QUkVRX0NPTlRFTlQgXTogdXNlIHByb2JlIHJl
cXVlc3Qgd2l0aCBvbmx5IHJhdGUgSUVzIGluIHNjYW5zCgkJKiBbIENBTl9SRVBMQUNFX1BUSzAg
XTogY2FuIHNhZmVseSByZXBsYWNlIFBUSyAwIHdoZW4gcmVrZXlpbmcKCQkqIFsgQ09OVFJPTF9Q
T1JUX05PX1BSRUFVVEggXTogZGlzYWJsZSBwcmUtYXV0aCBvdmVyIG5sODAyMTEgY29udHJvbCBw
b3J0IHN1cHBvcnQKCQkqIFsgREVMX0lCU1NfU1RBIF06IGRlbGV0aW9uIG9mIElCU1Mgc3RhdGlv
biBzdXBwb3J0CgkJKiBbIFNDQU5fRlJFUV9LSFogXTogc2NhbiBvbiBrSHogZnJlcXVlbmN5IHN1
cHBvcnQKCQkqIFsgQ09OVFJPTF9QT1JUX09WRVJfTkw4MDIxMV9UWF9TVEFUVVMgXTogdHggc3Rh
dHVzIGZvciBubDgwMjExIGNvbnRyb2wgcG9ydCBzdXBwb3J0Cgo=
--000000000000acb97c05cd1f5605--
