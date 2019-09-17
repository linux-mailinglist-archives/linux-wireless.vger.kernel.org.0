Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C671B4B54
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfIQJzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 05:55:10 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:52201 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfIQJzJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 05:55:09 -0400
Received: from [10.1.14.125] (vpn.streamunlimited.com [91.114.0.140])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46Xdkz3cdMz5tlb;
        Tue, 17 Sep 2019 11:55:07 +0200 (CEST)
Subject: [PATCH] wireless-regdb: Create entry for united European region
From:   Emil Petersky <emil.petersky@streamunlimited.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
References: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
 <20190907235636.GA8256@ubuntu-xps13>
 <a5bdfce7-e974-37bb-c1d1-956d4572703c@streamunlimited.com>
 <39933518-6a65-fab3-4a66-8f44fc319d57@streamunlimited.com>
Openpgp: preference=signencrypt
Message-ID: <76f464e9-8806-ecbf-2dc8-67bb4190ecc7@streamunlimited.com>
Date:   Tue, 17 Sep 2019 11:55:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <39933518-6a65-fab3-4a66-8f44fc319d57@streamunlimited.com>
Content-Type: multipart/mixed;
 boundary="------------721EDA64A3BDC61691136963"
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------721EDA64A3BDC61691136963
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Create entry for united European region, as usage of frequency bands
is harmonized over EU and almost all CEPT countries as well.

All EU countries and almost all CEPT countries accepted decisions
2005/513/EC (5GHz RLAN, EN 301 893)
and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
 EU decision 2005/513/EC:
https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 EU decision 2006/771/EC:
https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
Harmonized CEPT countries:
https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
Such decision make sense to create united European region (EU) in regdb

United region for EU in regdb will enable much easier handling of proper
wlan parameters on embedded devices sold across the Europe.

Following 40 EU/CEPT countries are fully harmonized:
AD    Andorra
AL     Albania
AT     Austria
BA     Bosnia and Herzegovina
BE     Belgium
BG     Bulgaria
CH     Switzerland
CY     Cyprus
CZ     Czechia
DE     Germany
DK     Denmark
EE     Estonia
ES     Spain
FI     Finland
FR     France
GB     United Kingdom of Great Britain and Northern Ireland
GR     Greece
HR     Croatia
HU     Hungary
IE     Ireland
IS     Iceland
IT     Italy
LI     Liechtenstein
LT     Lithuania
LU     Luxembourg
LV     Latvia
MC     Monaco
MD     Moldova
ME     Montenegro
MK     Macedonia
MT     Malta
NL     Netherlands
NO     Norway
PL     Poland
PT     Portugal
RO     Romania
RS     Serbia
SE     Sweden
SI     Slovenia
SK     Slovakia

Best regards,

Emil

-- 

Emil Petersky

________________________________________________________________________

StreamUnlimited Engineering GmbH
High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, 1100 Vienna, Austria
Office: +43 1 667 2002 4679 Fax: +43 1 667 2002 4401
Mail to: emil.petersky@streamunlimited.com
Visit us: www.streamunlimited.com

Meet us at:
IFA - Berlin, 6-11 September, hall 1.2/booth 224
CEDIA - Denver, 12-14 September
Hong Kong Electronics show - Hong Kong, 13 - 16 October


--------------721EDA64A3BDC61691136963
Content-Type: text/plain; charset=UTF-8;
 name="0001-wireless-regdb-Create-entry-for-united-European-region.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-wireless-regdb-Create-entry-for-united-European-region.";
 filename*1="patch"

RnJvbSBiMDUwMGQ4NGVhMGMyNDdmNzFlY2JlZDkwZDM4Y2U2OGNkMmFmOGI4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBFbWlsIFBldGVyc2t5IDxlbWlsLnBldGVyc2t5QHN0
cmVhbXVubGltaXRlZC5jb20+CkRhdGU6IFR1ZSwgMTcgU2VwIDIwMTkgMTE6NDU6MDQgKzAy
MDAKU3ViamVjdDogW1BBVENIXSB3aXJlbGVzcy1yZWdkYjogQ3JlYXRlIGVudHJ5IGZvciB1
bml0ZWQgRXVyb3BlYW4gcmVnaW9uCgpTaWduZWQtb2ZmLWJ5OiBFbWlsIFBldGVyc2t5IDxl
bWlsLnBldGVyc2t5QHN0cmVhbXVubGltaXRlZC5jb20+CgpDcmVhdGUgZW50cnkgZm9yIHVu
aXRlZCBFdXJvcGVhbiByZWdpb24sIGFzIHVzYWdlIG9mIGZyZXF1ZW5jeSBiYW5kcwppcyBo
YXJtb25pemVkIG92ZXIgRVUgYW5kIGFsbW9zdCBhbGwgQ0VQVCBjb3VudHJpZXMgYXMgd2Vs
bC4KCkFsbCBFVSBjb3VudHJpZXMgYW5kIGFsbW9zdCBhbGwgQ0VQVCBjb3VudHJpZXMgYWNj
ZXB0ZWQgZGVjaXNpb25zIDIwMDUvNTEzL0VDICg1R0h6IFJMQU4sIEVOIDMwMSA4OTMpCmFu
ZCAyMDA2Lzc3MS9FQyAoYW1lbmRlZCBieSAyMDA4LzQzMi9FQywgU2hvcnQtUmFuZ2UgRGV2
aWNlcywgRU4gMzAwIDQ0MCkKIEVVIGRlY2lzaW9uIDIwMDUvNTEzL0VDOiBodHRwczovL2V1
ci1sZXguZXVyb3BhLmV1L2xlZ2FsLWNvbnRlbnQvRU4vVFhULz91cmk9Q0VMRVg6MDIwMDVE
MDUxMy0yMDA3MDIxMwogRVUgZGVjaXNpb24gMjAwNi83NzEvRUM6IGh0dHBzOi8vZXVyLWxl
eC5ldXJvcGEuZXUvbGVnYWwtY29udGVudC9FTi9UWFQvP3VyaT1DRUxFWDowMjAwOEQwNDMy
LTIwMDgwNjExCkhhcm1vbml6ZWQgQ0VQVCBjb3VudHJpZXM6IGh0dHBzOi8vd3d3LmVjb2Rv
Y2RiLmRrL2Rvd25sb2FkLzI1YzQxNzc5LWNkNmUvUmVjNzAwM2UucGRmClN1Y2ggZGVjaXNp
b24gbWFrZSBzZW5zZSB0byBjcmVhdGUgdW5pdGVkIEV1cm9wZWFuIHJlZ2lvbiAoRVUpIGlu
IHJlZ2RiCgpVbml0ZWQgcmVnaW9uIGZvciBFVSBpbiByZWdkYiB3aWxsIGVuYWJsZSBtdWNo
IGVhc2llciBoYW5kbGluZyBvZiBwcm9wZXIKd2xhbiBwYXJhbWV0ZXJzIG9uIGVtYmVkZGVk
IGRldmljZXMgc29sZCBhY3Jvc3MgdGhlIEV1cm9wZS4KLS0tCiBkYi50eHQgfCAxMyArKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RiLnR4dCBiL2RiLnR4dAppbmRleCAzMGI5MzE4Li44OTY0NTczIDEwMDY0NAotLS0g
YS9kYi50eHQKKysrIGIvZGIudHh0CkBAIC0yNiw2ICsyNiwxOSBAQCBjb3VudHJ5IDAwOgog
CSMgSUVFRSA4MDIuMTFhZCAoNjBHSHopLCBjaGFubmVscyAxLi4zCiAJKDU3MjQwIC0gNjM3
MjAgQCAyMTYwKSwgKDApCiAKKyMgQWxsIEVVIGNvdW50cmllcyBhbmQgYWxtb3N0IGFsbCBD
RVBUIGNvdW50cmllcyBhY2NlcHRlZCBkZWNpc2lvbnMgMjAwNS81MTMvRUMgKDVHSHogUkxB
TiwgRU4gMzAxIDg5MykKKyMgYW5kIDIwMDYvNzcxL0VDIChhbWVuZGVkIGJ5IDIwMDgvNDMy
L0VDLCBTaG9ydC1SYW5nZSBEZXZpY2VzLCBFTiAzMDAgNDQwKQorIyAgRVUgZGVjaXNpb24g
MjAwNS81MTMvRUM6IGh0dHBzOi8vZXVyLWxleC5ldXJvcGEuZXUvbGVnYWwtY29udGVudC9F
Ti9UWFQvP3VyaT1DRUxFWDowMjAwNUQwNTEzLTIwMDcwMjEzCisjICBFVSBkZWNpc2lvbiAy
MDA2Lzc3MS9FQzogaHR0cHM6Ly9ldXItbGV4LmV1cm9wYS5ldS9sZWdhbC1jb250ZW50L0VO
L1RYVC8/dXJpPUNFTEVYOjAyMDA4RDA0MzItMjAwODA2MTEKKyMgSGFybW9uaXplZCBDRVBU
IGNvdW50cmllczogaHR0cHM6Ly93d3cuZWNvZG9jZGIuZGsvZG93bmxvYWQvMjVjNDE3Nzkt
Y2Q2ZS9SZWM3MDAzZS5wZGYKK2NvdW50cnkgRVU6IERGUy1FVFNJCisJKDI0MDAgLSAyNDgz
LjUgQCA0MCksICgxMDAgbVcpCisJKDUxNTAgLSA1MjUwIEAgODApLCAoMjAwIG1XKSwgTk8t
T1VURE9PUiwgQVVUTy1CVywgd21tcnVsZT1FVFNJCisJKDUyNTAgLSA1MzUwIEAgODApLCAo
MTAwIG1XKSwgTk8tT1VURE9PUiwgREZTLCBBVVRPLUJXLCB3bW1ydWxlPUVUU0kKKwkoNTQ3
MCAtIDU3MjUgQCAxNjApLCAoNTAwIG1XKSwgREZTLCB3bW1ydWxlPUVUU0kKKwkjIHNob3J0
IHJhbmdlIGRldmljZXMgKEVUU0kgRU4gMzAwIDQ0MC0xKQorCSg1NzI1IC0gNTg3NSBAIDgw
KSwgKDI1IG1XKQorCiAjIEFEIGFzIHBhcnQgb2YgQ0VQVCBhY2NlcHRlZCBkZWNpc2lvbnMg
MjAwNS81MTMvRUMgKDVHSHogUkxBTiwgRU4gMzAxIDg5MykKICMgYW5kIDIwMDYvNzcxL0VD
IChhbWVuZGVkIGJ5IDIwMDgvNDMyL0VDLCBTaG9ydC1SYW5nZSBEZXZpY2VzLCBFTiAzMDAg
NDQwKQogIyAgRVUgZGVjaXNpb24gMjAwNS81MTMvRUM6IGh0dHBzOi8vZXVyLWxleC5ldXJv
cGEuZXUvbGVnYWwtY29udGVudC9FTi9UWFQvP3VyaT1DRUxFWDowMjAwNUQwNTEzLTIwMDcw
MjEzCi0tIAoyLjIzLjAud2luZG93cy4xCgo=
--------------721EDA64A3BDC61691136963--
